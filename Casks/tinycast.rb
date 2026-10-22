# frozen_string_literal: true

cask "tinycast" do
  version "0.12.1"
  sha256 "e9d3da2c0a1bb3b813ce41cce52934fbd07c04941689cf4e8e58ba3284f796c5"

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
