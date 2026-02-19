cask "museeks" do
  version "0.23.3"
  sha256 "5322dfbbb3791b9efc3c103908bfefea26dda335ee06abacc615e122776112ef"

  url "https://github.com/martpie/museeks/releases/download/#{version}/Museeks_#{version}_universal.dmg",
      verified: "github.com/martpie/museeks/"
  name "museeks"
  desc "Simple, clean and cross-platform music player"
  homepage "https://museeks.io/"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url "https://github.com/martpie/museeks"
    strategy :github_latest
  end

  app "Museeks.app"

  zap trash: [
    "~/Library/Application Support/Museeks",
    "~/Library/Caches/Museeks",
    "~/Library/Preferences/Museeks.plist",
    "~/Library/Saved Application State/Museeks.savedState",
    "~/Library/WebKit/Museeks",
  ]
end
