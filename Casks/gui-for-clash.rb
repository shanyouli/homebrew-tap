cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.8"
  sha256 arm:   "528a2c58830f5fb9ae7a768071d69d5cee3028b8ef4eb97c4f62080923ecd55b",
         intel: "8f065ca3011e87d4e23cd2ad99958cb9867115ad5c6b806234b3c8dfc7adf068"

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
