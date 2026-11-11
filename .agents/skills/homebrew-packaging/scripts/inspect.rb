# typed: strict
# frozen_string_literal: true

# 通过 brew ruby 运行；默认把配方指向的安装包下载到 Homebrew 缓存（不安装），--file 只读检查本地文件。
require "digest"
require "fileutils"
require "open3"
require "optparse"
require "tmpdir"

# 从草稿 cask 或本地安装包读取制品元数据：app 名称、bundle id、最低系统版本、架构、签名状态与 zap 候选。
# 支持 dmg、pkg、zip、tar.gz/tgz 以及已解包的 .app 目录。
module ArtifactInspector
  VERSION = "2.0.0"
  # 运行验证时等待应用落盘数据的默认秒数。
  DEFAULT_WAIT = 8
  PLIST_KEYS = %w[
    CFBundleIdentifier CFBundleDisplayName CFBundleName CFBundleExecutable
    CFBundleShortVersionString CFBundleVersion LSMinimumSystemVersion
  ].freeze
  ARCH_ALIASES = {
    "arm64" => :arm, "aarch64" => :arm,
    "x64" => :intel, "x86_64" => :intel, "intel" => :intel
  }.freeze
  ZAP_CANDIDATES = [
    "~/Library/Application Support/%s",
    "~/Library/Caches/%s",
    "~/Library/Preferences/%s.plist",
    "~/Library/Saved Application State/%s.savedState",
    "~/Library/WebKit/%s",
  ].freeze
  SUPPORTED_FORMATS = "dmg、pkg、zip、tar.gz、.app"

  # 系统命令执行失败时抛出，附带命令与 stderr。
  class CommandFailedError < StandardError; end

  # 检查对象不满足前提（格式不支持、缺少 app 或 Info.plist）时抛出。
  class CheckError < StandardError; end

  module_function

  # 解析命令行并执行检查。
  # 参数：arguments 为命令行参数；返回退出码（0 成功、1 检查失败、2 参数或环境错误）。
  def main(arguments)
    options = parse_options(arguments)
    return 0 if options[:help]

    if options[:local_file]
      path = Pathname(options[:local_file]).expand_path
      raise ArgumentError, "文件不存在：#{path}" unless path.exist?

      cask = options[:cask_path] && load_cask(Pathname(options[:cask_path]).expand_path, resolve_arch(options[:arch]))
      return inspect_artifact(path.realpath, cask:, declared_version: cask&.version&.to_s,
                                           run: options[:run], wait: options[:wait])
    end

    raise ArgumentError, "请提供配方文件路径" if arguments.empty?
    raise ArgumentError, "一次只能检查一个配方文件" if arguments.length > 1

    cask_path = Pathname(arguments.fetch(0)).expand_path
    artifact, cask = fetch_artifact(cask_path, resolve_arch(options[:arch]))
    inspect_artifact(artifact, cask:, declared_version: cask.version.to_s,
                     run: options[:run], wait: options[:wait])
  rescue OptionParser::ParseError, ArgumentError => e
    warn "用法错误：#{e.message}"
    2
  rescue StandardError, ScriptError => e
    warn "检查失败：#{e.class}: #{e.message}"
    1
  end

  # 解析命令行选项；--run 必须与 --yes 同时出现，避免误运行未签名应用。
  # 参数：arguments 为命令行参数；返回选项哈希；参数矛盾时抛出 ArgumentError。
  def parse_options(arguments)
    options = { run: false, confirmed: false, wait: DEFAULT_WAIT }
    parser = OptionParser.new do |opts|
      opts.banner = "用法：brew ruby #{__FILE__} -- [--arch arm64|x64] [--run --yes] 配方路径"
      opts.separator "       brew ruby #{__FILE__} -- --file 本地安装包 [--cask 配方路径] [--run --yes]"
      opts.separator "支持 #{SUPPORTED_FORMATS}；默认联网下载到 Homebrew 缓存（不安装）。"
      opts.on("--file PATH", "只读检查本地安装包，跳过下载") { |value| options[:local_file] = value }
      opts.on("--cask PATH", "配合 --file 提供配方，用于版本比对") { |value| options[:cask_path] = value }
      opts.on("--arch ARCH", "按指定架构解析配方（arm64 或 x64）") { |value| options[:arch] = value }
      opts.on("--run", "运行包内主 app，核对运行时数据目录（不安装）") { options[:run] = true }
      opts.on("--yes", "确认执行 --run（会运行安装包内的应用）") { options[:confirmed] = true }
      opts.on("--wait SECONDS", Integer, "运行后等待落盘的秒数（默认 #{DEFAULT_WAIT}）") { |value| options[:wait] = value }
      opts.on("-v", "--version", "显示脚本版本") do
        puts "inspect.rb #{VERSION}"
        return { help: true }
      end
      opts.on("-h", "--help", "显示帮助") do
        puts opts
        return { help: true }
      end
    end
    parser.parse!(arguments)
    return options if options[:help]
    raise ArgumentError, "--run 必须同时指定 --yes 确认（会运行安装包内的应用）" if options[:run] && !options[:confirmed]
    raise ArgumentError, "--cask 只能与 --file 一起使用" if options[:cask_path] && !options[:local_file]

    options
  end

  # 加载草稿 cask（不依赖 tap 注册），按架构解析 URL 与 SHA-256。
  # 参数：path 为配方路径，arch 为模拟架构；返回 cask 实例。
  def load_cask(path, arch)
    require "cask/cask_loader"

    Homebrew::SimulateSystem.with(os: :macos, arch:) do
      Cask::CaskLoader::FromContentLoader.new(path.read).load(config: nil)
    end
  end

  # 加载草稿 cask 并经 Homebrew Download API 下载到缓存。
  # 参数：path 为配方路径，arch 为模拟架构；返回 [下载文件路径, cask 实例]；下载或校验失败时抛出异常。
  def fetch_artifact(path, arch)
    require "cask/download"

    Homebrew::SimulateSystem.with(os: :macos, arch:) do
      cask = load_cask(path, arch)
      puts "解析：#{cask.token} #{cask.version}（#{arch}）"
      # 当前架构缺少 URL 时提前给出可操作提示，避免落到 Download 内部错误。
      if cask.url.nil?
        raise CheckError, "配方在 #{arch} 架构下没有可用安装包，请用 --arch 指定其他架构或补全对应 stanza"
      end

      puts "下载：#{cask.url}"
      download = Cask::Download.new(cask)
      # 配方未声明 SHA-256 时跳过完整性校验并提示，由人工核对摘要。
      verified = !cask.sha256.nil?
      artifact = download.fetch(verify_download_integrity: verified, timeout: 600)
      warn "配方未声明 SHA-256，已跳过完整性校验" unless verified
      puts "缓存：#{artifact}"
      puts "SHA-256：#{Digest::SHA256.file(artifact).hexdigest}"
      [artifact, cask]
    end
  end

  # 判断安装包格式。
  # 参数：path 为安装包或应用路径；返回 :dmg/:pkg/:zip/:tar/:app；不支持的格式抛出 CheckError。
  def artifact_format(path)
    name = path.basename.to_s.downcase
    return :app if path.directory? && name.end_with?(".app")
    return :pkg if name.end_with?(".pkg", ".mpkg")
    return :tar if name.end_with?(".tar.gz", ".tgz", ".tar.bz2", ".tar.xz", ".tar")

    format = path.extname.downcase.delete_prefix(".").to_sym
    return format if [:dmg, :zip].include?(format)

    raise CheckError, "不支持的安装包格式：#{path.basename}（支持 #{SUPPORTED_FORMATS}）"
  end

  # 把安装包展开为可遍历的目录树（DMG 只读挂载，其余解包到临时目录）。
  # 参数：artifact 为安装包路径；向块传入扫描根目录，返回后自动卸载或清理。
  def with_app_root(artifact)
    case artifact_format(artifact)
    when :app
      yield artifact
    when :dmg
      Dir.mktmpdir("inspect-dmg-") do |temporary|
        mountpoint = Pathname(temporary)/"volume"
        mountpoint.mkpath
        run!("hdiutil", "attach", "-readonly", "-nobrowse", "-quiet",
             "-mountpoint", mountpoint.to_s, artifact.to_s)
        begin
          yield mountpoint
        ensure
          detach(mountpoint)
        end
      end
    else
      Dir.mktmpdir("inspect-#{artifact_format(artifact)}-") do |temporary|
        destination = Pathname(temporary)/"unpacked"
        expand_artifact(artifact, destination)
        yield destination
      end
    end
  end

  # 解包非 DMG 安装包到指定目录。
  # 参数：artifact 为安装包路径，destination 为目标目录；失败时抛出 CommandFailedError。
  def expand_artifact(artifact, destination)
    case artifact_format(artifact)
    when :pkg
      # pkgutil 要求目标路径尚不存在，否则报 "File exists"。
      FileUtils.rm_rf(destination)
      run!("pkgutil", "--expand-full", artifact.expand_path.to_s, destination.to_s)
    when :zip
      destination.mkpath
      run!("ditto", "-x", "-k", artifact.expand_path.to_s, destination.to_s)
    else
      destination.mkpath
      run!("tar", "-xf", artifact.expand_path.to_s, "-C", destination.to_s)
    end
  end

  # 在扫描根目录中查找应用包，跳过嵌套在其他 .app 内的组件（如 Helpers）。
  # 参数：root 为扫描根目录或 .app 本身；返回去重后的应用包路径数组。
  def find_apps(root)
    return [root.realpath] if root.directory? && root.basename.to_s.downcase.end_with?(".app")

    Dir.glob((root/"**/*.app").to_s)
       .map { |path| Pathname(path) }
       .reject { |app| nested_in_app?(app) }
       .select(&:directory?)
       .map(&:realpath).uniq
  end

  # 判断应用包是否嵌在其他 .app 内部。
  # 参数：app 为应用包路径；返回布尔值。
  def nested_in_app?(app)
    app.dirname.to_s.split(File::SEPARATOR).any? { |part| part.downcase.end_with?(".app") }
  end

  # 选出主应用：目录层级最浅且路径最短的应用包，用于版本比对与运行时验证。
  # 参数：apps 为应用包路径数组；返回主应用路径。
  def primary_app(apps)
    apps.min_by { |app| [app.dirname.to_s.length, app.basename.to_s] }
  end

  # 展开安装包并读取各应用的元数据；run 为 true 时对主应用执行运行时验证。
  # 参数：artifact 为安装包路径，cask 为草稿（可为 nil），declared_version 为配方声明版本，
  # run 为是否运行应用，wait 为运行后等待秒数；返回退出码 0；不安装，挂载点与临时目录均清理。
  def inspect_artifact(artifact, cask: nil, declared_version: nil, run: false, wait: DEFAULT_WAIT)
    with_app_root(artifact) do |root|
      apps = find_apps(root)
      raise CheckError, "安装包中没有找到 .app（格式 #{artifact_format(artifact)}）" if apps.empty?

      primary = primary_app(apps)
      apps.each { |app| report_app(app, declared_version:, primary:) }
      verify_runtime(primary, wait:) if run
    end
    0
  end

  # 输出单个应用的元数据、签名状态、版本一致性与 zap 候选。
  # 参数：app 为应用包路径，declared_version 为配方声明版本（可为 nil），primary 为主应用路径；
  # 无返回值。
  def report_app(app, declared_version:, primary: nil)
    plist = app/"Contents/Info.plist"
    raise CheckError, "缺少 Info.plist：#{plist}" unless plist.file?

    values = PLIST_KEYS.to_h { |key| [key, plist_value(plist, key)] }
    puts ""
    suffix = nil
    suffix = "（附属）" if primary && app.basename != primary.basename
    puts "应用：#{app.basename}#{suffix}"
    PLIST_KEYS.each { |key| puts "  #{key}：#{values.fetch(key) || "（未声明）"}" }

    executable = values.fetch("CFBundleExecutable")
    executable = app/"Contents/MacOS/#{executable}" if executable
    executable ||= (app/"Contents/MacOS").children.first
    puts "  架构：#{macho_archs(executable).join("、")}" if executable&.file?

    puts "  签名：#{signature_summary(app)}"

    bundle_version = values.fetch("CFBundleShortVersionString")
    # 只对主应用比对版本：附属应用（辅助工具、卸载器）版本号体系不同，比对会产生误导性噪音。
    if declared_version && bundle_version && (primary.nil? || app.basename == primary.basename)
      verdict = (bundle_version == declared_version) ? "一致" : "不一致，需人工核对"
      puts "  版本：配方 #{declared_version} 与制品 #{bundle_version}#{verdict}"
    end

    identifier = values.fetch("CFBundleIdentifier")
    return unless identifier

    puts "  zap 候选（需运行时或源码证据确认，不要直接照抄）："
    ZAP_CANDIDATES.each { |template| puts "    #{format(template, identifier)}" }
  end

  # 运行时验证：把主应用拷贝到临时目录、移除隔离标记后运行，核对实际落盘路径并清理本次新增数据。
  # 参数：app 为应用包路径，wait 为运行后等待秒数；无返回值。只清理本次运行新建的路径，
  # 运行前已存在的路径一律保留。
  def verify_runtime(app, wait:)
    plist = app/"Contents/Info.plist"
    identifier = plist_value(plist, "CFBundleIdentifier")
    raise CheckError, "缺少 CFBundleIdentifier，无法核对运行时数据目录" unless identifier

    name = plist_value(plist, "CFBundleName") || plist_value(plist, "CFBundleDisplayName") ||
           app.basename(".app").to_s
    tracked = runtime_paths(identifier, name)
    preexisting = tracked.select { |path| Pathname(path).expand_path.exist? }

    Dir.mktmpdir("inspect-run-") do |temporary|
      sandbox = Pathname(temporary)
      copy = sandbox/app.basename
      # 只读挂载点无法直接移除隔离标记，先拷贝到可写目录。
      FileUtils.cp_r(app.to_s, copy.to_s, preserve: true)
      Open3.capture3("xattr", "-dr", "com.apple.quarantine", copy.to_s)

      puts ""
      puts "运行时验证：#{app.basename}（拷贝到临时目录，不安装）"
      launched = launch_app?(copy)
      sleep wait
      created = report_runtime_paths(tracked, preexisting, label: "运行后")
      created |= report_runtime_paths(tracked, preexisting, label: "退出后", quiet_empty: true) if quit_app?(copy, name)
      cleanup_runtime_paths(created)
      warn "未能启动 #{app.basename}，运行时验证未完成" unless launched
    end
  end

  # 列出与运行时验证相关的路径：zap 候选（按 bundle id）加开机自启的 LaunchAgent。
  # 参数：identifier 为 bundle id，name 为应用名；返回路径字符串数组。
  def runtime_paths(identifier, name)
    ZAP_CANDIDATES.map { |template| format(template, identifier) } +
      ["~/Library/LaunchAgents/#{name}.plist"]
  end

  # 输出本次运行新增的路径；quiet_empty 为 true 时没有新增则不额外输出。
  # 参数：tracked 为全部候选路径，preexisting 为运行前已存在的路径，label 为阶段名，
  # quiet_empty 为是否静默空结果；返回本次新增且存在的路径数组。
  def report_runtime_paths(tracked, preexisting, label:, quiet_empty: false)
    created = tracked.select do |path|
      preexisting.exclude?(path) && Pathname(path).expand_path.exist?
    end
    if created.empty?
      puts "  #{label}：没有新增数据目录" unless quiet_empty
    else
      puts "  #{label}：新增 #{created.length} 项"
      created.each { |path| puts "    #{path}" }
    end
    created
  end

  # 删除本次运行新建的运行时数据路径。
  # 参数：paths 为路径数组；返回 nil；删除失败时告警但不中断。
  def cleanup_runtime_paths(paths)
    if paths.empty?
      puts "  清理：无需清理（未新增数据目录）"
      return
    end

    puts "  清理：移除本次运行新增的 #{paths.length} 项"
    paths.each do |path|
      expanded = Pathname(path).expand_path
      FileUtils.rm_rf(expanded)
      puts "    已删除 #{path}"
    rescue => e
      warn "    删除失败 #{path}：#{e.message}"
    end
  end

  # 启动临时目录中的应用包。
  # 参数：copy 为应用包路径；返回布尔值表示是否启动成功。
  def launch_app?(copy)
    _stdout, stderr, status = Open3.capture3("open", "-n", copy.to_s)
    warn "启动失败：#{stderr.strip}" unless status.success?
    status.success?
  end

  # 优雅退出应用，失败时按临时拷贝路径强制结束进程。
  # 参数：name 为应用名，copy 为应用包路径；返回布尔值表示应用是否已退出。
  def quit_app?(copy, name)
    Open3.capture3("osascript", "-e", "tell application #{name.inspect} to quit")
    return true if wait_for_exit?(copy, 3)

    Open3.capture3("pkill", "-f", "#{copy}/Contents/MacOS/")
    wait_for_exit?(copy, 3)
  end

  # 轮询等待应用退出。
  # 参数：copy 为应用包路径，seconds 为最长等待秒数；返回布尔值表示是否已退出。
  def wait_for_exit?(copy, seconds)
    seconds.times do
      return true unless process_running?(copy)

      sleep 1
    end
    !process_running?(copy)
  end

  # 判断临时拷贝的应用进程是否仍在运行。
  # 参数：copy 为应用包路径；返回布尔值。
  def process_running?(copy)
    _stdout, _stderr, status = Open3.capture3("pgrep", "-f", "#{copy}/Contents/MacOS/")
    status.success?
  end

  # 读取 Info.plist 中的单个键，键不存在或读取失败时返回 nil。
  # 参数：plist 为 Info.plist 路径，key 为键名；返回键值字符串或 nil。
  def plist_value(plist, key)
    stdout, _stderr, status = Open3.capture3("/usr/libexec/PlistBuddy", "-c", "Print :#{key}", plist.to_s)
    value = stdout.strip
    (status.success? && !value.empty?) ? value : nil
  end

  # 返回 Mach-O 文件的架构列表；lipo 无法识别时返回空数组。
  # 参数：executable 为可执行文件路径；返回架构名字符串数组。
  def macho_archs(executable)
    stdout, _stderr, status = Open3.capture3("lipo", "-archs", executable.to_s)
    status.success? ? stdout.split : []
  end

  # 汇总应用的签名与公证状态：签名者、签名校验结果和公证检查结果。
  # 参数：app 为应用包路径；返回一行描述字符串。
  def signature_summary(app)
    _stdout, stderr, status = Open3.capture3("codesign", "-dv", app.to_s)
    authority = stderr[/^Authority=(.+)$/, 1]
    team = stderr[/^TeamIdentifier=(.+)$/, 1]

    lines = [authority || (team && "团队 #{team}") || (status.success? ? "已签名" : "未签名或读取失败")]
    _stdout, _stderr, verify = Open3.capture3("codesign", "--verify", "--strict", app.to_s)
    lines << (verify.success? ? "签名校验通过" : "签名校验失败")
    _stdout, _stderr, notarized = Open3.capture3(
      "codesign", "--verify", "-R=notarized", "--check-notarization", app.to_s
    )
    lines << (notarized.success? ? "已公证" : "未公证或无法确认")
    lines.join("；")
  end

  # 把 --arch 参数映射为模拟架构；未指定时使用本机架构。
  # 参数：flag 为命令行架构别名；返回 :arm 或 :intel。
  def resolve_arch(flag)
    return Homebrew::SimulateSystem.current_arch if flag.nil?

    mapped = ARCH_ALIASES[flag.downcase]
    raise ArgumentError, "未知架构 #{flag}（支持 arm64 或 x64）" if mapped.nil?

    mapped
  end

  # 卸载挂载点：常规卸载失败时强制卸载，仍失败时仅告警不抛出。
  # 参数：mountpoint 为挂载目录；无返回值。
  def detach(mountpoint)
    _stdout, _stderr, status = Open3.capture3("hdiutil", "detach", "-quiet", mountpoint.to_s)
    return if status.success?

    _stdout, stderr, forced = Open3.capture3("hdiutil", "detach", "-force", mountpoint.to_s)
    warn "卸载失败：#{stderr.strip}" unless forced.success?
  end

  # 运行系统命令，失败时抛出带 stderr 的异常。
  # 参数：command 为命令与参数；返回 stdout 内容。
  def run!(*command)
    stdout, stderr, status = Open3.capture3(*command)
    raise CommandFailedError, "#{command.fetch(0)} 失败：#{stderr.strip}" unless status.success?

    stdout
  end
end

exit ArtifactInspector.main(ARGV) if $PROGRAM_NAME == __FILE__
