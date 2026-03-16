cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "2.1.1"
  sha256 arm:   "8e87b4e8bcf783662f7f501fbc1bd13c74d8e14e4fd7005a8bbeea0fc4c2ceeb",
         intel: "b6132991f9fd17241c38ed71fb71444e1278d2890f827c356a24376d73adfbb6"

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
