cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "9c9b05817253468945a3bd5ee1e628dd029a33e3d14d58b3a6023ab8db4976a3",
         intel: "8198819d55308be72f104ecf5833b36fba9e9f3815aa4d3e06730456420ae56e"

  url "https://github.com/NuclearPlayer/nuclear-xrd/releases/download/player%40#{version}/nuclear-music-player_#{version}_#{arch}.dmg",
      verified: "github.com/NuclearPlayer/nuclear-xrd/"
  name "nuclear-player"
  desc "Streaming music player that finds free music for you"
  homepage "https://nuclearplayer.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "nuclear-music-player.app"

  zap trash: [
    "~/Library/Caches/com.nuclearplayer",
    "~/Library/Preferences/com.nuclearplayer.plist",
    "~/Library/WebKit/com.nuclearplayer",
  ]
end
