cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.0"
  sha256 arm:   "4915a9323587d47955af9b1b2215275b4cd9515ed2fc4102527675eeb08f20c1",
         intel: "a7d4a95b93d3e278dc3a3d986bfc2a3ba666807b905aba754ce02147465a297c"

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
