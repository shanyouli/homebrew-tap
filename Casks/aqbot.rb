cask "aqbot" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.163"
  sha256 arm:   "5491d230b44033f3e94c5cbc24f290c320a4de9f6aff271646e324efd0bda292",
         intel: "2821f4c5bbfe3ab798baca77770e0ff3824d6e20d6449b244be4180950b630f9"

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
