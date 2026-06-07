cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.25.1"
  sha256 arm:   "4dc6d777337316cd0f8b800cc664587f606e4ac98a774a909165951e6de013f8",
         intel: "b7da0b3c58949571fed012aaa9f1b2243e2415972fe0010bd1833847505e3d75"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-(?:Alpha|dev)(?:(?:-|\.)\d+)?)?)$/i)
  end

  depends_on :macos

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
