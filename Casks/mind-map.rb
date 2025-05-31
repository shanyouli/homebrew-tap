cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.15.0"
  sha256 arm:   "3df476d6f3675b8107f1b877c0e759839991e74383b571f437f74a485f5cd77a",
         intel: "61638f912e902112fd3d5958d9293d7b0c6d6ef07fefce952d5880a34d691c4d"

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
