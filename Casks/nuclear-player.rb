cask "nuclear-player" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.0"
  sha256 arm:   "5a35ec5622ef5e8cb0e7e8b958e34ebd51207a77221bd411c0f12ac29523bc03",
         intel: "9fd5e5e4d5ce6b409327147dba6f5dcabae495133f022e5791f406c3538ab1b0"

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
