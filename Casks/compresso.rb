cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "1.4.0"
  sha256 arm:   "bc2820a5e2458175d8c77e58da600b71e718e3f6480b1ac876e8933726109bd4",
         intel: "4d4424273eac3ef196145869a18a783f73f07ca57052d530ad4eee783e75b7fa"

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
