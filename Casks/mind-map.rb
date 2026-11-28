cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.21.1"
  sha256 arm:   "aae14723174342c35dd002c5d4e390240cabad711871504f202e820a72031446",
         intel: "2ee6f4b29e700f0d43ffa1df428d2a35b4f6280c1d7c4016db250d10f88fe3bb"

  url "https://github.com/wanglin2/mind-map/releases/download/#{version}/-mac-#{version}-#{arch}.dmg"
  name "mind-map"
  desc "Relatively powerful web mind map"
  homepage "https://github.com/wanglin2/mind-map"

  livecheck do
    url "https://github.com/wanglin2/mind-map/releases/latest"
    strategy :page_match
    regex(%r{href=.*?/tag/(\d+(?:\.\d+)+)["' >]}i)
  end

  depends_on :macos

  app "思绪思维导图.app"

  zap trash: [
    "~/Library/Preferences/com.electron.thoughts.plist",
    "~/Library/Saved Application State/com.electron.thoughts.savedState",
  ]
end
