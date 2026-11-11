# cask 最小配方模板：复制到 Casks/<token>.rb 后按证据填充 <> 占位符，
# 删除所有未使用的注释行；编写规范见 references/cask-guidelines.md，取证流程见 SKILL.md 第 3 步。
cask "<token>" do
  version "<x.y.z>"
  sha256 "<64 位十六进制>"

  url "https://github.com/<owner>/<repo>/releases/download/v#{version}/<Asset>-#{version}-<platform>-<arch>.dmg"
  name "<DisplayName>"
  desc "<英文一句话功能描述，小写开头，不以 name 开头>"
  homepage "https://<project-homepage>/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # macOS 专属应用保留；跨平台应用删除此行。
  # 单架构发行时另加：depends_on arch: :arm64
  depends_on :macos

  app "<AppName>.app"
  # 其他 artifact 按证据添加：binary "<name>" / pkg "<installer>.pkg"（pkg 还需 uninstall pkgutil:）

  # zap 只写有证据的路径（SKILL.md 第 3 步：inspect 候选 + 源码证据 + 运行时验证）；
  # 仅一项时直接写字符串不套数组；bundle id 与实际数据目录冲突时以实际为准。
  # zap trash: [
  #   "~/Library/Application Support/<bundle.id>",
  #   "~/Library/Caches/<bundle.id>",
  #   "~/Library/Preferences/<bundle.id>.plist",
  #   "~/Library/Saved Application State/<bundle.id>.savedState",
  #   "~/Library/WebKit/<bundle.id>",
  # ]

  # caveats 是最后一组、写在 zap 之后；仅写有证据的安装后事项（Gatekeeper/权限）。
  # caveats <<~EOS
  #   <签名/公证状态与放行方式，或需要手动授予的权限>
  # EOS
end
