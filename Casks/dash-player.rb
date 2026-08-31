cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.6.0"
  sha256 arm:   "a72d4a24f04b5c1ed023bff41e0a38001c2f8c46fd70f9efe831ffcb19b8d8c0",
         intel: "4a3e3a09264cc218ee46e629780d91fca51c007c8d9cd62c7ec1b764753a1499"

  url "https://github.com/solidSpoon/DashPlayer/releases/download/v#{version}/DashPlayer-#{version}-#{arch}.dmg"
  name "dash-player"
  desc "为英语学习者量身打造的视频播放器，助你通过观看视频、沉浸真实语境，轻松提升英语水平"
  homepage "https://github.com/solidSpoon/DashPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "DashPlayer.app"
end
