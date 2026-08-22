cask "mrrss" do
  version "1.3.27"
  sha256 "b8011b5ddeedd1a3a4f57bec6ba3d724827822efe08815d4549399e2b8625b37"

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
