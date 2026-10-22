cask "aqbot" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.164"
  sha256 arm:   "79d27ab9f4b32355d6783b0a688b84151845bc17838745e3ed47104a9dc42206",
         intel: "2e17213f6b8f2c6314bedb3f7fdb2e82323c39484e3731103a51ad7af6faa1d3"

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
