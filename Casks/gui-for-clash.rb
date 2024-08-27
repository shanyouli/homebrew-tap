cask "gui-for-clash" do
  version "1.8.3"
  arch arm: "arm64", intel: "amd64"
  sha256 arm: "4dd412188df722974f3bffdf1709daad3d42f22c990b439839e33adb0fd3778b",
         intel: "ebae3765a1477615341a7219426d8e1e01c0ad965f8f31f55cb931f7aef829c9"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "A GUI program developed by vue3 + wails. "
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
