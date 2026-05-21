cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.19.0"
  sha256 arm:   "3af90de473a655f1cf388ae3562e532775f0ed6b105ec98df08aaa6297274e1f",
         intel: "f84d8c231451c5bd104529d001c164ccfea0089a54a8ff2bb1e3f023eb27e8e6"

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
