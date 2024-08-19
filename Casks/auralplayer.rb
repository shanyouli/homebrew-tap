cask "auralplayer" do
  version "3.25.2"
  sha256 "39687b8d068e435ef9253ed366b71250038bfe0927cad52650c5a5cf83cbb04d"

  url "https://github.com/kartik-venugopal/aural-player/releases/download/v#{version}/AuralPlayer-#{version}.dmg"
  name "AuralPlayer"
  desc "An audio player for macOS, inspired by Winamp."
  homepage "https://github.com/kartik-venugopal/aural-player"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Aural.app"

  zap trash: [
    "~/Library/Saved Application State/com.kv.Aural.savedState/",
    "~/Library/Preferences/com.kv.Aural.plist"
  ]
end
