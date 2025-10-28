cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.14.0"
  sha256 arm:   "0cb7c6bb7ab9e0d0ac062d74689c7a6f48cc7d2947bb63c9616c9f27bb9ddf12",
         intel: "18ea02f8356d1ffd8102514dcfe67da8ab6ea8b7fe5b713505da8f25b3617fb2"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-Alpha(?:-\d+)?)?)$/i)
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
