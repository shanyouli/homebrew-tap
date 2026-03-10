cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.18.2"
  sha256 arm:   "3aaaf1b60b93c6e55f62d4376d1515c90d15c63aaeb3c0fd693b3bc32ffee4c1",
         intel: "6848afbcfe6a277d5b4f4851a6468050cea3c38ca660c11f50f77c1890dad665"

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
