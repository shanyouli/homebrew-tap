cask "mrrss" do
  version "1.3.25"
  sha256 "72907dad25abfb6627c8352ad7f250d81a27fe3d57847689ce2d59d4bb6b62f1"

  url "https://github.com/WCY-dt/MrRSS/releases/download/v#{version}/MrRSS-#{version}-darwin-universal.dmg"
  name "MrRSS"
  desc "Modern, cross-platform, and free AI RSS reader"
  homepage "https://github.com/WCY-dt/MrRSS"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "MrRSS.app"

  zap trash: [
    "~/Library/Application Support/MrRSS",
    "~/Library/Caches/com.mrrss.app",
    "~/Library/WebKit/com.mrrss.app",
  ]
end
