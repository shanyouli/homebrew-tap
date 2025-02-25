cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.4"
  sha256 arm:   "c4e36f28410eb8b64db7dd7ff02d9b243e16f5b68b051da965c6878e60f0ca8c",
         intel: "bc17f4165a54b5381942b186fcec7fddfff137f51bea8b1e89b0f4010f9b6f41"

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
