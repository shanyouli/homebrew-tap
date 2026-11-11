# typed: strict
# frozen_string_literal: true

require "open3"
require "tmpdir"
require_relative "../scripts/validate"

# 不依赖额外测试库，通过子进程检查验证脚本的 CLI 与退出码。
module ValidatorTest
  SCRIPT = File.expand_path("../scripts/validate.rb", __dir__).freeze
  CASK = <<~RUBY.freeze
    cask "validation-fixture" do
      version "1.0"
      sha256 "#{"a" * 64}"

      url "https://example.com/fixture-\#{version}.dmg"
      name "Validation Fixture"
      desc "Example application for validation tests"
      homepage "https://example.com/"

      depends_on :macos

      app "Fixture.app"
    end
  RUBY
  FORMULA = <<~RUBY.freeze
    class ValidationFixture < Formula
      desc "Example utility for validation tests"
      homepage "https://example.com/"
      url "https://example.com/fixture-1.0.tar.gz"
      sha256 "#{"a" * 64}"
      license "MIT"

      # 测试用安装步骤；无参数、无返回值，校验不会执行它。
      def install
        prefix.install "README.md"
      end

      test do
        assert_path_exists prefix/"README.md"
      end
    end
  RUBY

  module_function

  # 执行 CLI 并检查退出码和诊断文本。
  # 参数：arguments 为路径/选项，status 为预期退出码，text 为预期文本，directory 为调用目录，script 为验证入口。
  # 返回 nil；断言失败时抛出异常，成功时输出一条测试结果。
  def check(arguments, status:, text:, directory:, script: SCRIPT)
    stdout, stderr, result = Open3.capture3(
      { "HOMEBREW_NO_AUTO_UPDATE" => "1" },
      HOMEBREW_BREW_FILE.to_s, "ruby", script, "--", *arguments, chdir: directory
    )
    output = stdout + stderr
    if result.exitstatus != status || text.any? { |expected| output.exclude?(expected) }
      raise "测试失败：#{arguments.inspect}，预期 #{status}，实际 #{result.exitstatus}\n#{output}"
    end

    puts "通过：#{arguments.inspect}（退出码 #{status}）"
  end

  # 在带空格的临时目录创建可信的测试配方，覆盖参数、加载、审计和样式失败分支。
  # 无参数、无返回值；测试结束自动删除临时目录，不修改仓库配方或 tap。
  def run
    Dir.mktmpdir("validator-tests-") do |temporary|
      root = Pathname(temporary)/"fixtures with spaces"
      root.mkpath
      directory = root.to_s
      cask = root/"Casks/nested/validation-fixture.rb"
      formula = root/"Formula/validation-fixture.rb"
      cask.dirname.mkpath
      formula.dirname.mkpath
      cask.write(CASK)
      formula.write(FORMULA)
      (root/"empty").mkpath
      (root/"archive").mkpath
      (root/"archive/ignored.rb").write("不是可加载的 Ruby")

      check([], status: 2, text: ["请指定文件或目录"], directory:)
      check(["--help"], status: 0, text: ["--all", "文件或目录"], directory:)
      check(["--unknown"], status: 2, text: ["invalid option"], directory:)
      check(["--all", cask.to_s], status: 2, text: ["不能与文件或目录参数混用"], directory:)
      check(["missing.rb"], status: 2, text: ["路径不存在"], directory:)
      check(["empty"], status: 2, text: ["没有找到可校验的配方文件"], directory:)
      check(["archive/ignored.rb"], status: 2, text: ["仅支持 Casks/ 或 Formula/"], directory:)
      check([cask.to_s, formula.to_s, cask.to_s], status: 0,
            text: ["样式检查：2 个文件", "0 个审计失败，样式通过"], directory:)
      check(["Casks/"], status: 0, text: ["样式检查：1 个文件"], directory:)
      check(["."], status: 0, text: ["样式检查：2 个文件"], directory:)
      check(["--all"], status: 0, text: [(OfflineValidator::ROOT/"Casks").to_s], directory:)

      # 不属于 Git 仓库的脚本副本不能猜测全量扫描根目录，但显式路径仍然可用。
      copied_script = root/"copy/scripts/validate.rb"
      copied_script.dirname.mkpath
      copied_script.write(File.read(SCRIPT))
      check(["--all"], status: 2, text: ["无法从脚本位置定位 Git 仓库"], directory:,
            script: copied_script.to_s)
      check([cask.to_s, formula.to_s], status: 0, text: ["样式检查：2 个文件"], directory:,
            script: copied_script.to_s)

      formula.write(FORMULA.sub("class ValidationFixture", "class UnexpectedFixture"))
      check([formula.to_s], status: 1, text: ["FormulaClassUnavailableError"], directory:)
      formula.write(FORMULA)

      cask.write(CASK.sub("validation-fixture", "wrong-token"))
      check([cask.to_s], status: 1, text: ["与文件名", "不一致"], directory:)
      cask.write("cask \"validation-fixture\" do\n")
      check([cask.to_s, formula.to_s], status: 1,
            text: ["SyntaxError", "审计：#{formula}", "样式失败"], directory:)
      cask.write(CASK.sub(/  sha256 .*\n/, ""))
      check([cask.to_s], status: 1, text: ["a sha256 stanza is required"], directory:)
      cask.write(CASK.sub('  name "Validation Fixture"', ' name "Validation Fixture"'))
      check([cask.to_s], status: 1, text: ["0 个审计失败，样式失败"], directory:)
    end
  end
end

ValidatorTest.run
