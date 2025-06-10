cask "museeks" do
  version "0.21.0"
  sha256 "c63395d6da4db61f34007badd853fd59a8da08e2eeacce0a1f5ab04cf6fdd828"

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

  depends_on macos: ">= :high_sierra"

  app "Museeks.app"

  zap trash: [
    "~/Library/Application Support/Museeks",
    "~/Library/Caches/Museeks",
    "~/Library/Preferences/Museeks.plist",
    "~/Library/Saved Application State/Museeks.savedState",
    "~/Library/WebKit/Museeks",
  ]
end
