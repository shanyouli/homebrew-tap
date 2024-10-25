cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.9"
  sha256 arm:   "468643141ed2a14db33befdf4c2e1ff73b6ba640a51d4ea06bef4f9a3fa14b01",
         intel: "6c05c00e531b9eb37e25ff2a949c607be6da936c6b234aaae3e1c09d4cec2e64"

  url "https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/download/v#{version}/GUI.for.SingBox-darwin-#{arch}.zip"
  name "gui-for-singbox"
  desc "Singbox client"
  homepage "https://github.com/GUI-for-Cores/GUI.for.SingBox"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.SingBox.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.SingBox",
    "~/Library/Preferences/com.wails.GUI.for.SingBox.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.SingBox.savedState",
    "~/Library/WebKit/com.wails.GUI.for.SingBox",
  ]
end
