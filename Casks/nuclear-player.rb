cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.10.0"
  sha256 arm:   "2e0ee2eb680edebb012708aa9bf0949535ed7d87dfefb6cc1dc9763589bb6c5f",
         intel: "0a6ba7854d4f0ad78532e19a8ccbbeb43763cc8c7005e3047c92523f1e1b7998"

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
