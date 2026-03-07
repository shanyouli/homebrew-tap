cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "2.1.0"
  sha256 arm:   "4e17087456d149a307dd5daf3390a7ac678dbc799fcaf77211981e74acf8f417",
         intel: "7598c5268226a01419fbb70ed170beb9302f213a473d5f613bd02633713b701e"

  url "https://github.com/codeforreal1/compressO/releases/download/#{version}/CompressO_#{version}_#{arch}.dmg"
  name "compressO"
  desc "Convert any video into a tiny size"
  homepage "https://github.com/codeforreal1/compressO"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "CompressO.app"

  zap trash: [
    "~/Library/Application Support/com.compresso.app",
    "~/Library/Caches/com.compresso.app",
    "~/Library/Preferences/com.compresso.app.plist",
    "~/Library/Saved Application State/com.compresso.app.savedState",
    "~/Library/WebKit/com.compresso.app",
  ]
end
