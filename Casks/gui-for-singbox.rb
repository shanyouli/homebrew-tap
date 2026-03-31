cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.22.0"
  sha256 arm:   "17a2e337bc7b043205f386c7003dff5dffc5296a0252d9a72434346461f912b5",
         intel: "74af0642bda1cbdb1a6789a7f92b581434d640ec3c1780a496f32709e1331349"

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
