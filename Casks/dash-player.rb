cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "4.2.3"
  sha256 arm:   "82885fc23c42ea5d5b338a7fd2987fc5775b5a6d9c6f2894d0af4a4d39c2e76b",
         intel: "c32629eda9cbbeca8b963694beb12a75b83762bbdad9a4a96364d1af6dd57845"

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
