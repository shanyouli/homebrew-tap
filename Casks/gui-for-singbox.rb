cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.8-Alpha"
  sha256 arm:   "2a56ba3da53139defbfd3c271aefbf4be2489c495855be6c9c0b849c34c8c18f",
         intel: "c18a7de5dc2b280c9aa881946e906b444a5cc1504c1c31e3650fa3c3cb74320d"

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
