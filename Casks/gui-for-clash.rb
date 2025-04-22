cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.6"
  sha256 arm:   "cacee953edb4865d3f1bdec0c635954139394097bf85a31750ae25a210bd3e87",
         intel: "32bc7b8724f556b568aafc5b26553e0acf54379dca8ef8e39e7e9b758b6b827f"

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
