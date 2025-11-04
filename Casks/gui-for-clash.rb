cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.14.1"
  sha256 arm:   "d5685d5e92f078d1ecd8f8f7c28ac66f1bbbca082bed8b7cbcc4f98e3e63b3da",
         intel: "1ba31209f6567d4cdcf37e1c5fe881bb0e8a9e38a8dc326580b56c8851d3dbb8"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-Alpha(?:-\d+)?)?)$/i)
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
