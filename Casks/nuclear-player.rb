cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.11.0"
  sha256 arm:   "a4d7bba5ada6f3d2135d27b5b9e753f83386b376332c849346005fb9d45af9e7",
         intel: "ec31531c7c301a7fc9df88da28635250b5334599cdbda3bfa94b5019ce8bbdd4"

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
