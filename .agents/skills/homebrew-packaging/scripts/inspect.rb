# typed: strict
# frozen_string_literal: true

# 通过 brew ruby 运行；默认把配方指向的安装包下载到 Homebrew 缓存（不安装），--file 只读检查本地文件。
require "digest"
require "open3"
require "optparse"
require "tmpdir"

# 从草稿 cask 或本地安装包读取制品元数据：app 名称、bundle id、最低系统版本、架构、签名状态与 zap 候选。
module ArtifactInspector
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

  # 系统命令执行失败时抛出，附带命令与 stderr。
  class CommandFailedError < StandardError; end

  # 检查对象不满足前提（非 DMG、缺少 app 或 Info.plist）时抛出。
  class CheckError < StandardError; end

  module_function

  # 解析命令行并执行检查。
  # 参数：arguments 为命令行参数；返回退出码（0 成功、1 检查失败、2 参数或环境错误）。
  def main(arguments)
    local_file = nil
    arch = nil
    parser = OptionParser.new do |options|
      options.banner = "用法：brew ruby #{__FILE__} -- [--arch arm64|x64] 配方路径"
      options.separator "       brew ruby #{__FILE__} -- --file 本地.dmg"
      options.separator "默认联网下载到 Homebrew 缓存（不安装）；--file 只读检查本地文件，可复用缓存中的安装包。"
      options.on("--file PATH", "只读检查本地安装包，跳过下载") { |value| local_file = value }
      options.on("--arch ARCH", "按指定架构解析配方（arm64 或 x64）") { |value| arch = value }
      options.on("-h", "--help", "显示帮助") do
        puts options
        return 0
      end
    end
    parser.parse!(arguments)

    if local_file
      path = Pathname(local_file).expand_path
      raise ArgumentError, "文件不存在：#{path}" unless path.file?

      return inspect_artifact(path.realpath)
    end

    raise ArgumentError, "请提供配方文件路径" if arguments.empty?
    raise ArgumentError, "一次只能检查一个配方文件" if arguments.length > 1

    cask_path = Pathname(arguments.fetch(0)).expand_path
    artifact, cask = fetch_artifact(cask_path, resolve_arch(arch))
    inspect_artifact(artifact, cask:, declared_version: cask.version.to_s)
  rescue OptionParser::ParseError, ArgumentError => e
    warn "用法错误：#{e.message}"
    2
  rescue StandardError, ScriptError => e
    warn "检查失败：#{e.class}: #{e.message}"
    1
  end

  # 加载草稿 cask（不依赖 tap 注册），按架构解析 URL 与 SHA-256，并经 Homebrew Download API 下载到缓存。
  # 参数：path 为配方路径，arch 为模拟架构；返回 [下载文件路径, cask 实例]；下载或校验失败时抛出异常。
  def fetch_artifact(path, arch)
    require "cask/cask_loader"
    require "cask/download"

    Homebrew::SimulateSystem.with(os: :macos, arch:) do
      cask = Cask::CaskLoader::FromContentLoader.new(path.read).load(config: nil)
      puts "解析：#{cask.token} #{cask.version}（#{arch}）"
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

  # 只读挂载 DMG 并读取各应用的元数据，输出签名状态与 zap 候选。
  # 参数：artifact 为本地 DMG 路径，cask 为草稿（可为 nil），declared_version 为配方声明版本；
  # 返回退出码 0；不修改任何文件，挂载点在退出前卸载。
  def inspect_artifact(artifact, cask: nil, declared_version: nil)
    raise CheckError, "仅支持检查 DMG 安装包：#{artifact.extname}" if artifact.extname.casecmp(".dmg") != 0

    Dir.mktmpdir("inspect-") do |temporary|
      mountpoint = Pathname(temporary)/"volume"
      mountpoint.mkpath
      run!("hdiutil", "attach", "-readonly", "-nobrowse", "-quiet",
           "-mountpoint", mountpoint.to_s, artifact.to_s)
      begin
        # 只匹配顶层 .app，嵌套时仅遍历真实目录：DMG 里的 Applications 符号链接指向 /Applications，
        # 直接用 "*/*.app" 会穿透链接扫到用户已安装的全部应用。
        apps = mountpoint.glob("*.app")
        if apps.empty?
          nested = mountpoint.children.select(&:directory?).reject(&:symlink?)
          apps = nested.flat_map { |directory| directory.glob("*.app") }
        end
        apps = apps.map(&:realpath).uniq
        raise CheckError, "DMG 中没有找到 .app" if apps.empty?

        apps.each { |app| report_app(app, declared_version:) }
      ensure
        detach(mountpoint)
      end
    end
    0
  end

  # 输出单个应用的元数据、签名状态、版本一致性与 zap 候选。
  # 参数：app 为应用包路径，declared_version 为配方声明版本（可为 nil）；无返回值。
  def report_app(app, declared_version:)
    plist = app/"Contents/Info.plist"
    raise CheckError, "缺少 Info.plist：#{plist}" unless plist.file?

    values = PLIST_KEYS.to_h { |key| [key, plist_value(plist, key)] }
    puts ""
    puts "应用：#{app.basename}"
    PLIST_KEYS.each { |key| puts "  #{key}：#{values.fetch(key) || "（未声明）"}" }

    executable = values.fetch("CFBundleExecutable")
    executable = app/"Contents/MacOS/#{executable}" if executable
    executable ||= (app/"Contents/MacOS").children.first
    puts "  架构：#{macho_archs(executable).join("、")}" if executable&.file?

    puts "  签名：#{signature_summary(app)}"

    bundle_version = values.fetch("CFBundleShortVersionString")
    if declared_version && bundle_version
      verdict = (bundle_version == declared_version) ? "一致" : "不一致，需人工核对"
      puts "  版本：配方 #{declared_version} 与制品 #{bundle_version}#{verdict}"
    end

    identifier = values.fetch("CFBundleIdentifier")
    return unless identifier

    puts "  zap 候选（需运行时或源码证据确认，不要直接照抄）："
    ZAP_CANDIDATES.each { |template| puts "    #{format(template, identifier)}" }
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
