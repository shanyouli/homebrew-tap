cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.5"
  sha256 arm:   "d955b88c2045b13543157111ac26fa8fde34d604d000de4b1b9b351a2dd8a7a0",
         intel: "5412d56f48e8f6c35232bf8bedaa67002ed5b5ad56e82631b933ec05de230de8"

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
