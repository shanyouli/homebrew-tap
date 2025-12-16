cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.0"
  sha256 arm:   "cc09c2e8bf033b14e5e0279c883af0686333d865a7ee18b6516db3330e30330e",
         intel: "3b6e2231269355b0ef53035cbd308480f0d6d2d744c325ef4bc137652c39cfd4"
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
