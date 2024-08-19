cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "4.2.4"
  sha256 arm:   "84d265deaff935f421e69176e33c344eabfc2b3e8885f07c4359bc2a36b93eeb",
         intel: "bba77eb2c3112a574eeb3885208e9ce9f489efafd0821ca286727f9e6c48ceec"

  url "https://github.com/solidSpoon/DashPlayer/releases/download/v#{version}/DashPlayer-#{version}-#{arch}.dmg"
  name "dash-player"
  desc "为英语学习者量身打造的视频播放器，助你通过观看视频、沉浸真实语境，轻松提升英语水平"
  homepage "https://github.com/solidSpoon/DashPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "DashPlayer.app"

  zap trash: ""
end
