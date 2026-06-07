cask "spotube" do
  version "5.1.2"
  sha256 "27627dfd44190040af1a6ba6a86cdc4450399296a43a616940a94ae687ac0913"

  url "https://github.com/KRTirtho/spotube/releases/download/v#{version}/Spotube-macos-universal.dmg",
      verified: "github.com/KRTirtho/spotube/"
  name "Spotube"
  desc "Open source Spotify client"
  homepage "https://spotube.krtirtho.dev/"

  livecheck do
    url "https://github.com/KRTirtho/spotube"
    strategy :github_latest
  end

  depends_on :macos

  app "spotube.app"

  zap trash: [
    "~/Library/Application Scripts/oss.krtirtho.spotube",
    "~/Library/Containers/oss.krtirtho.spotube",
  ]
end
