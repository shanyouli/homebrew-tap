cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.14.0"
  sha256 arm:   "23f5ed52f89f5593d734287df2a3c952ed98bd1edde947a73b5b10e6e77aafe6",
         intel: "a8242d6e7d543b51261f594588a5268e36df8508406aaa157c7f4009285c9f8e"

  url "https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/download/v#{version}/GUI.for.SingBox-darwin-#{arch}.zip"
  name "gui-for-singbox"
  desc "Singbox client"
  homepage "https://github.com/GUI-for-Cores/GUI.for.SingBox"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-Alpha(?:-\d+)?)?)$/i)
  end

  app "GUI.for.SingBox.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.SingBox",
    "~/Library/Preferences/com.wails.GUI.for.SingBox.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.SingBox.savedState",
    "~/Library/WebKit/com.wails.GUI.for.SingBox",
  ]
end
