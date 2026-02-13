cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.4.0"
  sha256 arm:   "d99ece0690a64f56343acd34794f644947ddc073f0110a9b0ef3710e5683a696",
         intel: "872eeb13312e007ec1a634facd0f8b9f1f3d87d517e8416b5e26b7260cbfc074"

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
