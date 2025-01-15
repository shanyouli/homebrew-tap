cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.1"
  sha256 arm:   "be2f54ff47e316fa78478045b7462f2cd01efa54ad63d9b9cc4f34b1b202c406",
         intel: "02a561f84ab0ce449b49248d85bb5727b520ed9a3a886f84fddca88295695637"

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
