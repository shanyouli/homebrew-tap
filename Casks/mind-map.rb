cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.14.0"
  sha256 arm:   "9929d2adb6e4ac6b5381ad2f0a6240b20b35406043f2f5366df29361acef459d",
         intel: "adc2fc820064aae7af12e14ab91a51b7414e06c0bb28e5ff41a336e236b5fc27"

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
