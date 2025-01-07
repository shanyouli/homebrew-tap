cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.2"
  sha256 arm:   "0f950573597f67ec82d3b18b41948d49cf91b1a06721cc375e688799091fd0e6",
         intel: "2db29829e596a61dd8c48d6683a858018d6ceb14022a8e04f20c6916bf73f943"

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
