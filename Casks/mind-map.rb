cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.11.2"
  sha256 arm:   "3b88f222ddadbc3c6b5c65175457cd58d5d633e061736a6297ed8b481d2c9925",
         intel: "5812310c32536f36e84a756b244d39ba8886d07abd1d88777b9d011bddfa44a8"

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
