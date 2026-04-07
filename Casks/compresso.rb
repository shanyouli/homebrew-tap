cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "3.0.0"
  sha256 arm:   "5fe9e0b55d291328b13b867c817dd9339078f724339f01e57484972f4c088c3a",
         intel: "58c586817e38614bb7cf01ae13acb69ca60bb682156da8b99447165c2c6d3090"

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
