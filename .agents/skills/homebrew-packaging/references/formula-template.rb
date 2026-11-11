# formula 最小配方模板：复制到 Formula/<token>.rb 后按证据填充 <> 占位符；
# 类名 Token 替换为文件名首字母大写形式（如 lite-edit.rb → class LiteEdit），并删除所有未使用的注释行。
# 编写规范见 references/formula-guidelines.md，离线验证见 SKILL.md 第 5 步（编写测试不等于执行测试）。
class Token < Formula
  desc "<英文一句话功能描述，小写开头，不以 token 开头>"
  homepage "https://<project-homepage>/"
  url "https://github.com/<owner>/<repo>/archive/refs/tags/v#{version}.tar.gz"
  version "<x.y.z>"
  sha256 "<64 位十六进制>"
  license "<SPDX 表达式，如 MIT>"

  livecheck do
    url "https://github.com/<owner>/<repo>"
    strategy :github_latest
  end

  # 本仓库 formula 均声明 macOS 依赖；仅真实需要时才写最低版本 depends_on macos: :ventura。
  depends_on :macos
  # 构建依赖示例：depends_on "rust" => :build；产物自包含时不要声明运行时依赖。

  def install
    # DSL 优先：bin.install / libexec.install / share.install / man1.install / (pkgshare/"…").install
    # 修改脚本硬编码路径用 inreplace；构建命令用 system "make", "install" 形式（参数逐个传递）。
    bin.install "<binary-name>"
  end

  # 仅写有证据的安装后事项（权限、服务管理、配置位置）；无证据时删除整个方法。
  # def caveats
  #   <<~EOS
  #     <安装后需要知道的操作说明>
  #   EOS
  # end

  test do
    # 必须有意义：验证可执行与版本输出；不依赖网络、不写用户目录。
    assert_match version.to_s, shell_output("#{bin}/<binary-name> --version")
  end
end
