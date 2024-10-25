cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.9"
  sha256 arm:   "780ef6b554d90b0644a6eceff6eb188e3da94773a95a7f3856c46e571ca20de6",
         intel: "fcd1dcb536b681cf6cc3005314a3271873a8856779ec846594218e55a37f1142"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
