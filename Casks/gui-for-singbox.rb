cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.2"
  sha256 arm:   "477d49a0ef8f111ba9c54f86ca1a41994a8fcf5d188b3365b2e6c042e600e563",
         intel: "e01baa336038087430d45624b659293940d4342c88de59d82642281373d84e79"

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
