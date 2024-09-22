cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.6"
  sha256 arm:   "c6c0248b1c5215a72467c56ab77ac57fa09113c1ef4cf198b4cd6d142ab06879",
         intel: "e06a7d665a88fb72942f8789387ad0f3b5e51b0d76ad9cbbee8dc7384f8f1f00"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
