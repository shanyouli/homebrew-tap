cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.13.1"
  sha256 arm:   "a843269e727da41382987546d9d50c9049217221cd0308a792372bc3cffab9e3",
         intel: "f70f9edb55df117644b684bddecd4ade87c92f28475b1b5974d1e5d0eacc50a5"

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
