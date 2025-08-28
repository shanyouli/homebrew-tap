cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.9"
  sha256 arm:   "ad32cf40cf4931cb3a3eac2a28eca3cfe86eb9e3dfb69973456963f6e4ffd4b4",
         intel: "2c43df60df9ae8ac01e8b1c5b75345af4aec623b72261fc919c175018c23b8e4"

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
