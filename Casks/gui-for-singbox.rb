cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.4"
  sha256 arm:   "b08427d6845466239cf1bd60382223c67a311826747052023ec0294dafcd93ba",
         intel: "b0b15f0d305e02329748dfb217c19d118086e6002ab4c837bcbc1f1070ff64b7"

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
