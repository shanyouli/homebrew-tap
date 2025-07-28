cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.6"
  sha256 arm:   "f6e64d9d9f9c4a979a79f5651afb6f8e56a2939112767e0c77fcdcf4dffaf21f",
         intel: "f74eb4b7f9939111ef9dc0c4c083eee30f5e3dfe5c8cf60c15cf76c1e85264ad"

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
