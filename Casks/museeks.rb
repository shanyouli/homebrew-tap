cask "museeks" do
  version "0.21.1"
  sha256 "66eb933c0bcf7033bd851e811d841e07ef234485a5d8ebf9ab966a4e588133ab"

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
