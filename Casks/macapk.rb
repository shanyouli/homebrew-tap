# frozen_string_literal: true

cask "macapk" do
  version "1.0.2303"
  sha256 "af32b4d7e972f761629549818759cf1866d8f7c3a89b6e96b1bc8de585565d39"

  url "https://github.com/kksimp/Mac.apk/releases/download/v#{version}/macapk.dmg"
  name "Mac.apk"
  desc "Runs Android apps natively on Apple Silicon Macs"
  homepage "https://github.com/kksimp/Mac.apk"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 上游精确要求 macOS 26.4+（Info.plist LSMinimumSystemVersion），
  # DSL 仅支持到 :tahoe（26.x），26.0-26.3 由系统弹窗自行拦截
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Mac.apk.app"

  zap trash: [
    "~/Library/Application Support/MacApk",
    "~/Library/Logs/macapk",
    "~/Library/Preferences/org.macapk.launcher.plist",
    "~/Library/Saved Application State/org.macapk.launcher.savedState",
  ]
end
