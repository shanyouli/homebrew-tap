cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.7"
  sha256 arm:   "14d6e8c7a5b663fe9804970ce1b7bb69411b9acbf1d9498ee9920be6135317ca",
         intel: "c0b04a039fcd94c52f17bbf47981a0af29ae697c906a79eaad1f025133d77e7e"

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
