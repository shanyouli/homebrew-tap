cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.20.0"
  sha256 arm:   "bb1e858df69b369a9fd8cd41bddb6f4daeb4788a9f8721e4b051c0d130c7c9df",
         intel: "e9251f7cb43c0cc609ffd14ce89fc97feb59e1ba2189fd467658f12efb4be316"

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
