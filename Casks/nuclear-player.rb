cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.9"
  sha256 arm:   "c12b3db7ea25d791fc56d129fa6b757ab03c16e9b8616be2d4d165895deb7635",
         intel: "d514eb8635c4c142fb6706945001934a35aaa62422b37e79e62096349be95d1a"

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
