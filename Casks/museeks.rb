cask "museeks" do
  version "0.20.9"
  sha256 "2571aa5cb3ee4c3802906c1b304a7d31a6bad199b61a5b347e8627d42b9b9b4a"

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
