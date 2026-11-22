cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.19.1"
  sha256 arm:   "8a936f55b482723848f15e4bc0fad6d9f2c746aeb0a43f11c491599c7f587993",
         intel: "c8cf8f58f34bacf576e0928b2c9ace4d3fd84d0cdf6e9087b718bf093e763606"

  url "https://github.com/solidSpoon/DashPlayer/releases/download/v#{version}/DashPlayer-#{version}-#{arch}.dmg"
  name "dash-player"
  desc "为英语学习者量身打造的视频播放器，助你通过观看视频、沉浸真实语境，轻松提升英语水平"
  homepage "https://github.com/solidSpoon/DashPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "DashPlayer.app"
end
