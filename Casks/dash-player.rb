cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.5"
  sha256 arm:   "058edf48f3cb2b576f56a13d438e3c5cca1535252ebdb165467c6a7a38e1ffc0",
         intel: "a57dc4a98a1940ca2444022e8d51662e161ff6e9654fe8a44f4e9bb03e3db255"

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
