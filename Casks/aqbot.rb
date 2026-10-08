cask "aqbot" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.162"
  sha256 arm:   "ac3736150442b0f8aedd0df957c22f71bc7db56780a7b7956791225d856de909",
         intel: "16d75e485c751170a234ad7a96204c3b5c001ab82c7cdb8d9fb924a0cf332b7f"

  url "https://github.com/AQBot-Desktop/AQBot/releases/download/v#{version}/AQBot_#{version}_#{arch}.dmg"
  name "aqbot"
  desc "Lightweight, high-performance AI dialogue + AI Agent + AI gateway desktop client"
  homepage "https://github.com/AQBot-Desktop/AQBot"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "AQBot.app"

  zap trash: [
    "~/Library/Caches/top.aqbot.desktop",
    "~/Library/Preferences/top.aqbot.desktop.plist",
    "~/Library/WebKit/top.aqbot.desktop",
  ]
end
