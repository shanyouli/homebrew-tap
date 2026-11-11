# typed: strict
# frozen_string_literal: true

# 通过 brew ruby 运行；只加载可信的本地配方，不下载资源或安装校验依赖。
require "optparse"
require "style"

# 为本仓库的 cask 和 formula 提供不依赖 tap 注册状态的离线校验。
module OfflineValidator
  ROOT = Pathname(__dir__).ascend.find { |directory| (directory/".git").exist? }.freeze
  PACKAGE_DIRS = %w[Casks Formula].freeze

  module_function

  # 根据文件所在目录识别配方类型。
  # 参数：path 为 Ruby 文件路径；返回目录类型；不支持的路径抛出 ArgumentError。
  def package_type(path)
    directory = path.dirname.ascend.map { |parent| parent.basename.to_s }.find { |part| PACKAGE_DIRS.include?(part) }
    raise ArgumentError, "仅支持 Casks/ 或 Formula/ 下的 Ruby 文件：#{path}" if path.extname != ".rb" || !directory

    directory
  end

  # 收集指定文件或目录下的配方，只有 all 为 true 时扫描整个仓库。
  # 参数：arguments 为路径列表，all 为全量开关；返回去重、排序后的绝对路径；无有效文件时抛出异常。
  def collect_files(arguments, all: false)
    raise ArgumentError, "--all 不能与文件或目录参数混用" if all && !arguments.empty?
    raise ArgumentError, "请指定文件或目录，或使用 --all 校验全部配方" if !all && arguments.empty?

    targets = if all
      raise ArgumentError, "无法从脚本位置定位 Git 仓库，请显式指定配方文件或目录" unless ROOT

      PACKAGE_DIRS.map { |directory| ROOT/directory }
    else
      arguments.map { |arg| Pathname(arg) }
    end
    files = targets.flat_map do |target|
      path = target.expand_path
      raise ArgumentError, "路径不存在：#{path}" unless path.exist?

      if path.directory?
        directories = if path.each_filename.any? { |part| PACKAGE_DIRS.include?(part) }
          [path]
        else
          PACKAGE_DIRS.map { |directory| path/directory }.select(&:directory?)
        end
        directories.flat_map { |directory| directory.glob("**/*.rb") }
      else
        [path]
      end
    end.map(&:realpath).uniq.sort

    raise ArgumentError, "没有找到可校验的配方文件" if files.empty?

    files.each { |path| package_type(path) }
    files
  end

  # 从文件内容加载 cask 并执行严格离线审计，不设置 tap 身份。
  # 参数：path 为 cask 路径；返回审计问题列表；DSL 加载失败时抛出 Homebrew 异常。
  def audit_cask(path)
    require "cask/auditor"
    require "cask/cask_loader"

    cask = Cask::CaskLoader::FromContentLoader.new(path.read).load(config: nil)
    expected_token = path.basename(".rb").to_s
    if cask.token != expected_token
      raise ArgumentError, "cask token #{cask.token.inspect} 与文件名 #{expected_token.inspect} 不一致"
    end

    Cask::Auditor.audit(cask, audit_online: false, audit_strict: true,
                       audit_download: false, audit_signing: false, audit_new_cask: false).to_a
  end

  # 从文件内容加载 formula 并执行严格离线审计，不执行安装或 test do。
  # 参数：path 为 formula 路径；返回审计问题列表；DSL 加载失败时抛出 Homebrew 异常。
  def audit_formula(path)
    require "formula_auditor"
    require "formulary"

    formula = Formulary.from_contents(path.basename(".rb").to_s, path, path.read)
    auditor = Homebrew::FormulaAuditor.new(formula, strict: true, online: false)
    auditor.audit
    auditor.problems + auditor.new_formula_problems
  end

  # 逐文件审计后批量检查样式，某一文件失败不会跳过其余文件。
  # 参数：files 为配方路径数组；返回全部通过时的 true；向终端输出结果，不修改配方。
  def validate(files)
    failed = 0
    files.each do |path|
      puts "审计：#{path}"
      begin
        problems = (package_type(path) == "Casks") ? audit_cask(path) : audit_formula(path)
        problems.each { |problem| warn "#{path}: #{problem[:message]}" }
        failed += 1 unless problems.empty?
      rescue StandardError, SyntaxError => e
        warn "#{path}: #{e.class}: #{e.message}"
        failed += 1
      end
    end

    puts "样式检查：#{files.length} 个文件"
    # 直接使用 Style API：缺少本地 Ruby 依赖时报错，不调用自动安装依赖的 CLI 入口。
    style_passed = Homebrew::Style.check_style_and_print(files)
    puts "结果：#{files.length} 个文件，#{failed} 个审计失败，样式#{style_passed ? "通过" : "失败"}"
    failed.zero? && style_passed
  end

  # 解析命令行并运行校验。
  # 参数：arguments 为命令行参数；返回退出码（0 通过、1 校验失败、2 参数或环境错误）。
  def main(arguments)
    all = false
    parser = OptionParser.new do |options|
      options.banner = "用法：brew ruby #{__FILE__} -- [--all | 文件或目录 ...]"
      options.separator "默认必须指定路径；--all 扫描仓库的 Casks/ 和 Formula/，不扫描 archive/。"
      options.on("--all", "校验仓库全部配方（不能与路径混用）") { all = true }
      options.on("-h", "--help", "显示帮助") do
        puts options
        return 0
      end
    end
    parser.parse!(arguments)
    files = collect_files(arguments, all:)
    validate(files) ? 0 : 1
  rescue StandardError, ScriptError => e
    warn "校验失败：#{e.class}: #{e.message}"
    2
  end
end

exit OfflineValidator.main(ARGV) if $PROGRAM_NAME == __FILE__
