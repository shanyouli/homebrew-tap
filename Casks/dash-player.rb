cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.1"
  sha256 arm:   "557fc2fe6ac49a5e29d60bfcac82f6223fad37e0f50fefcc8f0a13973e225ba8",
         intel: "a4ffb68cc901be8a4395fc7bd2bdc59454c200fbfc758171151523e0d30bf42d"

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
