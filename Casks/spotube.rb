cask "spotube" do
  version "3.8.3"
  sha256 "3751ff572e50422f3302a8aa022e5a4e751070a0bf1202f71948447e70a46804"

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
