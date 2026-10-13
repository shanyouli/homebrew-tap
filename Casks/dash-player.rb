cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.13.3"
  sha256 arm:   "6a182f56060d2fe19f5dbe8be5b1c628e39ee4b7f8829241bea9ee2dd9011141",
         intel: "9893e26a7e96102d5ec3d4b5bc4039374361e6975380a7ee3fc43e33ae08f945"

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
