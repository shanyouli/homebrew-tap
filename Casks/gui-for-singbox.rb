cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.20.0"
  sha256 arm:   "e616fcb406c9d9ca5b2bc9f1fa9f20266ff5a7d88aa33bb7b1ecaf513fd1f1a7",
         intel: "ca33f463cd273ef1a02a7d7daccd1fcf32ab5371b2f275486d1fdabfe3dcea82"

  url "https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/download/v#{version}/GUI.for.SingBox-darwin-#{arch}.zip"
  name "gui-for-singbox"
  desc "Singbox client"
  homepage "https://github.com/GUI-for-Cores/GUI.for.SingBox"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-(?:Alpha|dev)(?:(?:-|\.)\d+)?)?)$/i)
  end

  app "GUI.for.SingBox.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.SingBox",
    "~/Library/Preferences/com.wails.GUI.for.SingBox.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.SingBox.savedState",
    "~/Library/WebKit/com.wails.GUI.for.SingBox",
  ]
end
