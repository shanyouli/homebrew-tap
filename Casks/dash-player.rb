cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.7"
  sha256 arm:   "80f39fbdfdda5faccde47486048f9f7bb63efda9296b7da9685c7536a5a34960",
         intel: "b6d7891f83f749d179e7056587ed1ae5b063ed98ba2d97e408fa5cdd1a6c322b"

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
