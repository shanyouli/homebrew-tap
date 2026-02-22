cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.7.0"
  sha256 arm:   "21b06dbee5a713b88b8a318d6294133b4355643046c5eb59282f1fbb411ef1c5",
         intel: "c4caf842014ae2351d499c14831e371fa48769d762889272034e9be0c76ff43d"

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
