cask "spotube" do
  version "3.8.2"
  sha256 "da7a961d00f12743dcc1388b01af1865f7eac2c7677a93295efa6a44f5f92713"

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
