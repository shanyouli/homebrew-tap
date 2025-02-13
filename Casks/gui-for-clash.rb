cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.2"
  sha256 arm:   "27fec5157082c4a1a221bc9edb89fdfa5c52d66e655b1180d281274fd2c7ee44",
         intel: "6abb73cd17e83f26b5854b132ffb3dd58c31b5b55606be0038b8b404ad2c4a4b"

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
