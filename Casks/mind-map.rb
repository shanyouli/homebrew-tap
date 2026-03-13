cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.18.3"
  sha256 arm:   "39f58c6a308be171d11b26507b5e15de54f0200866db32e8f0f7ff8e1555c2e2",
         intel: "aa965782d40bbb0a381564ffcf18921cb40c5ba4b97d75db948d627e4eabef55"

  url "https://github.com/wanglin2/mind-map/releases/download/#{version}/-mac-#{version}-#{arch}.dmg"
  name "mind-map"
  desc "Relatively powerful web mind map"
  homepage "https://github.com/wanglin2/mind-map"

  livecheck do
    url "https://github.com/wanglin2/mind-map/releases/latest"
    strategy :page_match
    regex(%r{href=.*?/tag/(\d+(?:\.\d+)+)["' >]}i)
  end

  app "思绪思维导图.app"

  zap trash: [
    "~/Library/Preferences/com.electron.thoughts.plist",
    "~/Library/Saved Application State/com.electron.thoughts.savedState",
  ]
end
