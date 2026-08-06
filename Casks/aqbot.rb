cask "aqbot" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.114"
  sha256 arm:   "2974707d822c906b9918845b53e3a0f3ccbb5c3f65c7809878bbf5cac12c2284",
         intel: "a67332f4c25b76499f74242237a9be6cafcca17cbd99afc6e3d6f10d3858eb8f"

  url "https://github.com/AQBot-Desktop/AQBot/releases/download/v#{version}/AQBot_#{version}_#{arch}.dmg"
  name "aqbot"
  desc "Lightweight, high-performance AI dialogue + AI Agent + AI gateway desktop client"
  homepage "https://github.com/AQBot-Desktop/AQBot"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "AQBot.app"

  zap trash: [
    "~/Library/Caches/top.aqbot.desktop",
    "~/Library/Preferences/top.aqbot.desktop.plist",
    "~/Library/WebKit/top.aqbot.desktop",
  ]
end
