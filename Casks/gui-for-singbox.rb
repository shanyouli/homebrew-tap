cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.6"
  sha256 arm:   "611bd8cd49809e236a7f973fea4d9b96cbd5af44cd13b03704e677746b517b8c",
         intel: "4348eb6985a2ab2b8eea510a75b002edb48fde0ae7c2cf353467a49f1a79100c"

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
