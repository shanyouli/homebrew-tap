cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.17.0"
  sha256 arm:   "e93476fb2a3578e460122a15fc6632767142f318d46e358b69eaaef0ac20e10b",
         intel: "cd7d7d459ae441ceff27c2c369376dfd02bd38cfedc4542d8fdb622565cc78cc"

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
