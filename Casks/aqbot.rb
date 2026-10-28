cask "aqbot" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.165"
  sha256 arm:   "e4de13eec17ae63f2b7dfd2ccf56dbcb21deda1d568e76ae3efba94886a53027",
         intel: "4136affe8068a1d90ca155e301ea771fa61fd41696828e6cd39720664bb69899"

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
