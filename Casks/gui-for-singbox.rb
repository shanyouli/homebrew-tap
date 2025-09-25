cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.0"
  sha256 arm:   "cad5d842c65ac71250db043bdeb88c508f549bcc2708862840bbfd52f148d77f",
         intel: "70f477cc99ff307f2a90c4893d8cfea8bb440d9161eb2a2d3c3e12e85ba5e464"

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
