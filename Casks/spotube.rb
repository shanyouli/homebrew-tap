cask "spotube" do
  version "3.9.0"
  sha256 "c30208298f9b98c2598a073600afd0320d78daebd9f83e8b39d77379d24ce5ff"

  url "https://github.com/KRTirtho/spotube/releases/download/v#{version}/Spotube-macos-universal.dmg",
      verified: "github.com/KRTirtho/spotube/"
  name "Spotube"
  desc "Open source Spotify client"
  homepage "https://spotube.krtirtho.dev/"

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
