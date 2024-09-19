cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.5"
  sha256 arm:   "e27b8e01319cfb57414c5c806b1cc23004233ea87ca242e37c04b54d007a7cd6",
         intel: "3465c3bdcad2dd649a11d2d9c162cd4e6edb0b5d458709888e52d91bc988fc02"

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
