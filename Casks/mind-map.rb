cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.16.0"
  sha256 arm:   "25175aa37b8ef2ed9390eac82048e71e8b6c1a53019e0869390b6464a96bbc4e",
         intel: "6180e755c248e0a863ed563e9012b26d42bb709c956cea24fcdbd0408e51bd97"

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
