cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.17.0"
  sha256 arm:   "b3ff6101d31bafb2e99e95110e7413c79f741e3569dd6de419e5f9ca3c56b19f",
         intel: "c32cff87e17a2dbf93d1eaeb3d2f0bb91ff9febc945f14525f26f75799a54f64"

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
