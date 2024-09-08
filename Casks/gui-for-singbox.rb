cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.3"
  sha256 arm:   "07dce42b1dd35303682dd18e247f64e2ca4b69ec606efde3e92d50da429a61f2",
         intel: "e8f3b1ac5ed51bf7b6eade4a8ef0ae0396fc4b000bf1cafb0524f82103de3f41"

  url "https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/download/v#{version}/GUI.for.SingBox-darwin-#{arch}.zip"
  name "gui-for-singbox"
  desc "singbox client"
  homepage "https://github.com/GUI-for-Cores/GUI.for.SingBox"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.SingBox.app"

  zap trash: [
    "~/Library/WebKit/com.wails.GUI.for.SingBox",
    "~/Library/Preferences/com.wails.GUI.for.SingBox.plist",
    "~/Library/Caches/com.wails.GUI.for.SingBox",
    "~/Library/Saved Application State/com.wails.GUI.for.SingBox.savedState",
  ]
end
