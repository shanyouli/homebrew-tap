cask "spotube" do
  version "3.8.0"
  sha256 "a900db1919e26bc2407259b60204f6142c61612e96a0db8358831b1bbea90c1d"

  url "https://github.com/KRTirtho/spotube/releases/download/v#{version}/Spotube-macos-universal.dmg"
  name "Spotube"
  desc "🎧 Open source Spotify client"
  homepage "https://github.com/KRTirtho/spotube"

  livecheck do
    url "https://github.com/KRTirtho/spotube"
    strategy :github_latest
  end

  app "spotube.app"

  zap trash: [
    "~/Library/Application Scripts/oss.krtirtho.spotube",
    "~/Library/Containers/oss.krtirtho.spotube",
  ]
end
