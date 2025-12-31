cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.10"
  sha256 arm:   "1556af4283eb89ee381c672728262a73292aef7f8585058f153bd6e0617fe8c6",
         intel: "52e709f07f0ebcf2df781968ac45d70d092ad604cb981b1c618f4eae4f4414e5"

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
