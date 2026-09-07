cask "mrrss" do
  version "1.3.31"
  sha256 "327d1b7aa32e39a891cc88d27f64982ba41203371a6bfd88f38809dd771c1d29"

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
