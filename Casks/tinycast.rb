# frozen_string_literal: true

cask "tinycast" do
  version "0.12.8"
  sha256 "22ce1ba191ce0d38473c09cec7ee8525b58ed28535935c67865fb2be5cb0fb4a"

  url "https://github.com/abue-ammar/tinycast/releases/download/v#{version}/Tinycast-#{version}.dmg"
  name "Tinycast"
  desc "Tiny, fully native launcher under 100 MB of RAM"
  homepage "https://github.com/abue-ammar/tinycast"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Tinycast.app"

  zap trash: [
    "~/Library/Application Support/com.tinycast.app",
    "~/Library/Caches/com.tinycast.app",
    "~/Library/HTTPStorages/com.tinycast.app",
    "~/Library/Preferences/com.tinycast.app.plist",
    "~/Library/Saved Application State/com.tinycast.app.savedState",
    "~/Library/WebKit/com.tinycast.app",
  ]
end
