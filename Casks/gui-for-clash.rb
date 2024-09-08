cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"
  version "1.8.4"
  sha256 arm:   "6657e9c450eadcc1ae00e2c9696acf482488d3793898fe75e15f4a7f5f5c369a",
         intel: "86cf1261d85964c46c447ac231b48d34647d721db4d36a01b7e016609ebdc84"

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
