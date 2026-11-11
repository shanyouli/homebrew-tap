# typed: strict
# frozen_string_literal: true

require "fileutils"
require "open3"
require "tmpdir"

# 不联网检查 inspect.rb：用 hdiutil/ditto/tar/pkgbuild 构建临时安装包 fixture，
# 覆盖 dmg、pkg、zip、tar.gz、.app 五种格式与参数、失败分支。
module InspectorTest
  SCRIPT = File.expand_path("../scripts/inspect.rb", __dir__).freeze
  PLIST = <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>CFBundleIdentifier</key>
        <string>com.validator.fixture</string>
        <key>CFBundleDisplayName</key>
        <string>Inspect Fixture</string>
        <key>CFBundleName</key>
        <string>InspectFixture</string>
        <key>CFBundleExecutable</key>
        <string>fixture</string>
        <key>CFBundleShortVersionString</key>
        <string>1.2.3</string>
        <key>LSMinimumSystemVersion</key>
        <string>11.0</string>
      </dict>
    </plist>
  XML
  CASK = <<~RUBY.freeze
    cask "inspect-fixture" do
      version "1.2.3"
      sha256 "#{"a" * 64}"

      url "https://example.com/fixture-\#{version}.dmg"
      name "Inspect Fixture"
      desc "Fixture used by inspect script tests"
      homepage "https://example.com/"

      depends_on :macos

      app "InspectFixture.app"
    end
  RUBY
  EXPECTED = [
    "InspectFixture.app", "com.validator.fixture", "Inspect Fixture", "fixture",
    "CFBundleShortVersionString：1.2.3", "LSMinimumSystemVersion：11.0",
    "架构：", "签名：", "zap 候选", "Application Support/com.validator.fixture"
  ].freeze

  module_function

  # 执行 CLI 并检查退出码和诊断文本。
  # 参数：arguments 为命令行参数，status 为预期退出码，text 为预期文本，not_text 为禁止出现的文本，
  # app_count 为预期“应用：”行数（nil 时不检查）；返回 nil；断言失败时抛出异常。
  def check(arguments, status:, text:, not_text: [], app_count: nil)
    stdout, stderr, result = Open3.capture3(
      { "HOMEBREW_NO_AUTO_UPDATE" => "1" },
      HOMEBREW_BREW_FILE.to_s, "ruby", SCRIPT, "--", *arguments
    )
    output = stdout + stderr
    failure = result.exitstatus != status ||
              text.any? { |expected| output.exclude?(expected) } ||
              not_text.any? { |forbidden| output.include?(forbidden) } ||
              (app_count && output.scan(/^应用：/).size != app_count)
    if failure
      raise "测试失败：#{arguments.inspect}，预期 #{status}，实际 #{result.exitstatus}\n#{output}"
    end

    puts "通过：#{arguments.inspect}（退出码 #{status}）"
  end

  # 运行系统命令，失败时抛出带 stderr 的异常。
  # 参数：command 为命令与参数；无返回值。
  def run!(*command)
    _stdout, stderr, status = Open3.capture3(*command)
    raise "命令失败：#{command.fetch(0)}\n#{stderr}" unless status.success?
  end

  # 构建带 fixture 应用的临时目录。
  # 参数：root 为临时根目录；返回应用包路径。
  def build_app(root)
    app = root/"InspectFixture.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Info.plist").write(PLIST)
    FileUtils.cp("/bin/echo", app/"Contents/MacOS/fixture")
    FileUtils.chmod(0755, app/"Contents/MacOS/fixture")
    app
  end

  # 检查参数错误与不需要 fixture 的分支。
  # 无参数、无返回值。
  def check_arguments
    check([], status: 2, text: ["请提供配方文件路径"])
    check(["--arch", "mips", "fixture.rb"], status: 2, text: ["未知架构"])
    check(["--file", "missing.dmg"], status: 2, text: ["文件不存在"])
    check(["--run", "fixture.rb"], status: 2, text: ["--run 必须同时指定 --yes"])
    check(["--cask", "fixture.rb"], status: 2, text: ["--cask 只能与 --file 一起使用"])
    check(["--version"], status: 0, text: ["inspect.rb 2"])
    check(["--help"], status: 0, text: ["--run", "支持 dmg、pkg、zip、tar.gz、.app"])
  end

  # 构建各格式 fixture 并逐一检查元数据输出。
  # 参数：root 为临时根目录，app 为应用包路径；无返回值。
  def check_formats(root, app)
    dmg = root/"fixture.dmg"
    run!("hdiutil", "create", "-fs", "HFS+", "-volname", "InspectFixture",
         "-srcfolder", app.dirname.to_s, dmg.to_s)
    check(["--file", dmg.to_s], status: 0, text: EXPECTED, app_count: 1)

    zip = root/"fixture.zip"
    run!("ditto", "-c", "-k", "--keepParent", app.to_s, zip.to_s)
    check(["--file", zip.to_s], status: 0, text: EXPECTED, app_count: 1)

    tarball = root/"fixture.tar.gz"
    run!("tar", "-czf", tarball.to_s, "-C", app.dirname.to_s, app.basename.to_s)
    check(["--file", tarball.to_s], status: 0, text: EXPECTED, app_count: 1)

    pkg = root/"fixture.pkg"
    run!("pkgbuild", "--root", app.dirname.to_s, "--identifier", "com.validator.fixture",
         "--version", "1.2.3", "--install-location", "/Applications", pkg.to_s)
    check(["--file", pkg.to_s], status: 0, text: EXPECTED, app_count: 1)

    # 已解包的 .app 目录直接检查，无需挂载或解包。
    check(["--file", app.to_s], status: 0, text: EXPECTED, app_count: 1)
  end

  # 检查版本比对、符号链接防护与失败分支。
  # 参数：root 为临时根目录，app 为应用包路径；无返回值。
  def check_metadata(root, app)
    cask = root/"Casks/inspect-fixture.rb"
    cask.dirname.mkpath
    cask.write(CASK)
    expected_version = EXPECTED + ["配方 1.2.3 与制品 1.2.3一致"]
    check(["--file", app.to_s, "--cask", cask.to_s], status: 0, text: expected_version)
    cask.write(CASK.sub('version "1.2.3"', 'version "9.9.9"'))
    check(["--file", app.to_s, "--cask", cask.to_s], status: 0, text: ["不一致，需人工核对"], app_count: 1)
    cask.write(CASK)

    # 安装包里的 Applications 符号链接指向 /Applications，遍历不得穿透链接扫到系统应用。
    (app.dirname/"Applications").make_symlink("/Applications")
    symlinked = root/"symlinked.dmg"
    run!("hdiutil", "create", "-fs", "HFS+", "-volname", "Symlinked",
         "-srcfolder", app.dirname.to_s, symlinked.to_s)
    check(["--file", symlinked.to_s], status: 0, text: EXPECTED, app_count: 1)

    (root/"notes.txt").write("不是安装包")
    check(["--file", (root/"notes.txt").to_s], status: 1, text: ["不支持的安装包格式"])

    empty = root/"empty.dmg"
    run!("hdiutil", "create", "-fs", "HFS+", "-volname", "Empty", "-size", "1m", empty.to_s)
    check(["--file", empty.to_s], status: 1, text: ["安装包中没有找到 .app"])
  end

  # 构建 fixture 并运行全部检查。
  # 无参数、无返回值；测试结束自动删除临时目录，不联网、不安装、不运行应用。
  def run
    check_arguments
    Dir.mktmpdir("inspect-tests-") do |temporary|
      root = Pathname(temporary)
      app = build_app(root)
      check_formats(root, app)
      check_metadata(root, app)
    end
  end
end

InspectorTest.run
