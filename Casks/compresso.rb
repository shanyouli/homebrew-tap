cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "4.2.0"
  sha256 arm:   "eb915c7b71751b21e7b59beb488923eac5418f6a50e2bd7b0738e00d5405057e",
         intel: "dcd9bcae510e5e46ec44b73676f427011d1975a3c24f68b0ca11f00add3d262b"

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
