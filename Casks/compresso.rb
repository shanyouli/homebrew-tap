cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "4.3.0"
  sha256 arm:   "9c18b9e49ad637fb95cc06ccfc7fa6886dde899a9cd99a4b0d4c5ad71f8e5b34",
         intel: "ace0190ecf593aee8a8aa8ee799720f7c459ef6818bd8e63723e70eeae0d032a"

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
