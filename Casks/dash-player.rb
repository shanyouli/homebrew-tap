cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.15.0"
  sha256 arm:   "131bf5be13b6afe5a5d2052538ef45d17c2d0ac9b19762395048ff9e0155c633",
         intel: "fe9360b6e7dff91410e95dd470d4799b4fd863b95ea3fe7c9968dd063bc5e37b"

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
