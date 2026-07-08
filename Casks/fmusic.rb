cask "fmusic" do
  version "1.1.1"
  sha256 "135e17d2d5ff39113e15b1d5f0f59d782699c8fec4c022e7f34fcf6257259700"

  url "https://github.com/wandercn/fmusic/releases/download/#{version}/fmusic_universal_v#{version}.dmg"
  name "fmusic"
  desc "Is a open source music player on SwiftUI"
  homepage "https://github.com/wandercn/fmusic"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "fmusic.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: "~/Library/Preferences/com.rustpub.fmusic.plist"
end
