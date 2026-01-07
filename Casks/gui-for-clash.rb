cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.17.0"
  sha256 arm:   "ccf993be0978021854f70aa32a1d2410793396ab20a1a04cc2b2c04285f04744",
         intel: "edba23adcecd1c8e4a4a13eb7eec938f3e8188957995e6710734c6c82b7554ad"

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
