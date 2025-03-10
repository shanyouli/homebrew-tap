cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.4"
  sha256 arm:   "1bcfa02669e14b75a587606ff8298c674aa953d6cd84943b33b1921e04bc637f",
         intel: "30e4638c767a507ef6d875c22583bed0c90a8148a6a2dfd21acc373c8d6e3da4"

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
