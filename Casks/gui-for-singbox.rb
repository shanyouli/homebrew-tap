cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.8"
  sha256 arm:   "38c62dde91a30edc02ab7d44ed6ad479678f7364602ee53ca6648fe8b8780882",
         intel: "0bcba8312388691a4d3f5a5541db6a03cf8e1a8b1b5b0556f4950d1c1784d511"

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
