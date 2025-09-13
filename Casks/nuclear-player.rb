cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.8"
  sha256 arm:   "ffe9da419936808597a0c6ae761c7b5481765e256ecef50307f3bcecd3543eb2",
         intel: "943b6fd45774afa9eb485cf3b648f0f769ccd822c842de1613d33e33c56b6c1e"

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
