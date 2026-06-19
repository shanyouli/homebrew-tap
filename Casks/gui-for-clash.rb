cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.25.2"
  sha256 arm:   "1d17692242bbf9a6f2b829392ee3b511291cad98d628c2988dd7aad66908b536",
         intel: "ce8a568469e722468fdb7e3472639c4b41b74e81fc48713cc2e5d7f5768ed26b"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-(?:Alpha|dev)(?:(?:-|\.)\d+)?)?)$/i)
  end

  depends_on :macos

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
