cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "4.1.0"
  sha256 arm:   "d94f22d5e49fd6189a537be854bbf8f06db5d446e7fba20c6792eb99b3d14436",
         intel: "0a399b65a3d11a6350da8bfd62f2d74dff68149b498421abef874ecbcfb59f63"

  url "https://github.com/codeforreal1/compressO/releases/download/#{version}/CompressO_#{version}_#{arch}.dmg"
  name "compressO"
  desc "Convert any video into a tiny size"
  homepage "https://github.com/codeforreal1/compressO"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "CompressO.app"

  zap trash: [
    "~/Library/Application Support/com.compresso.app",
    "~/Library/Caches/com.compresso.app",
    "~/Library/Preferences/com.compresso.app.plist",
    "~/Library/Saved Application State/com.compresso.app.savedState",
    "~/Library/WebKit/com.compresso.app",
  ]
end
