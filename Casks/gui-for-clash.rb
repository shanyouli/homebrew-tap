cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.0"
  sha256 arm:   "406d1c3e0c733bdf19bba76e7f03f6fbb8d2f7244bf526c39b662983216bc4fb",
         intel: "95ebd1e3224ac4f8fa7e6670b187a6c4f1cb67f6d9d8ae4006291053bfea8cc1"

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
