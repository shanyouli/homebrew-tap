cask "mrrss" do
  version "1.3.22"
  sha256 "be1decd2b8019e33e26cd08dd30f702d6e0ef72cad36698c10d652af65b924f2"

  url "https://github.com/WCY-dt/MrRSS/releases/download/v#{version}/MrRSS-#{version}-darwin-universal.dmg"
  name "MrRSS"
  desc "Modern, cross-platform, and free AI RSS reader"
  homepage "https://github.com/WCY-dt/MrRSS"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "MrRSS.app"

  zap trash: [
    "~/Library/Application Support/MrRSS",
    "~/Library/Caches/com.mrrss.app",
    "~/Library/WebKit/com.mrrss.app",
  ]
end
