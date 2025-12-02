cask "museeks" do
  version "0.23.1"
  sha256 "8f7795c5921e2e43ea1bf0438b6f5ae717b05dfb00e017f5c50fea2c8bef5e5d"

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
