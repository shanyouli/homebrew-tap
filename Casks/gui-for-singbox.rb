cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.4"
  sha256 arm:   "1792210c5d2290c2bb4527cd4228180eca6e85ff5baed8d2b304dce566acf12c",
         intel: "8ed9721a7a3bd11261e97ef604e04a6e4e5b8c15371136e46b9aa539d04c8a47"

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
