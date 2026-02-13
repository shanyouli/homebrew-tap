cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.18.0"
  sha256 arm:   "a10d48117d0049dbabbfde7c90ebcea1c0d0a5fd194c2b82780bb34a95171050",
         intel: "bf38825e9309a728c44934902a1129c23b152a629f550d29539d54106516be8c"

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
