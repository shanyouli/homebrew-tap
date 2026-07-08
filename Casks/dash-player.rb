cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.0.1"
  sha256 arm:   "8302f159fd3223ed0bc8fe641efa2d3f3342cc360f8bd966870e52e4a9cc3d83",
         intel: "4f8933a086c87724052d4526c127b967ddd88fe1244822e7baaa8a51da9accbf"

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
