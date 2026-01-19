cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.19.0"
  sha256 arm:   "2bf7eadd8b39fe3fe66c5fa82846fa9a7b734214616ed62112baf61602e3ff9b",
         intel: "7f1e46e88f0c097a0238811a7e6d0ee95f9a6a6e1f464a0894436efe01e86465"

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
