cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.12.6"
  sha256 arm:   "1c858cea164511d2738a39e9b8f27ae953c396133c6d015a84de3c6d407b7193",
         intel: "7da146b6e78191e977e3aeb2928bac84fa228a74b2a780d00c92ff8140ca1185"

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
