cask "mrrss" do
  version "1.3.28"
  sha256 "7f178a6d0cb2741a4bae85b058313ca4f4946c103c3c34625630f70f6f8e286a"

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
