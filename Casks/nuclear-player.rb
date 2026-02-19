cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.5.0"
  sha256 arm:   "f580d44f50e8819c0971ca3c23b749cf2702e81105846582e87866601976e3de",
         intel: "611f473dbc12646438123468f6995d01eb22e90d5e10b0e3fcd93cfe82a29298"

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
