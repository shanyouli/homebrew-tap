cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.12.1"
  sha256 arm:   "3b78c5be6fb3aa9f13ec81450d46e5cc1d214f1ac8ca0ca88b3951515f64705f",
         intel: "5f2e9016c61e0e428bf787f1e802abee2ca2842f10f2b9030f6ab88dfad84c41"

  url "https://github.com/wanglin2/mind-map/releases/download/electron-#{version}/-mac-#{version}-#{arch}.dmg"
  name "mind-map"
  desc "Relatively powerful web mind map"
  homepage "https://github.com/wanglin2/mind-map"

  livecheck do
    url "https://github.com/wanglin2/mind-map/releases/latest"
    strategy :page_match
    regex(%r{href=.*?/tag/electron-(\d+(?:\.\d+)+)["' >]}i)
  end

  app "思绪思维导图.app"

  zap trash: [
    "~/Library/Preferences/com.electron.thoughts.plist",
    "~/Library/Saved Application State/com.electron.thoughts.savedState",
  ]
end
