cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "4.3.0"
  sha256 arm:   "1ce1bfcc36a887e7c05c13653e83447b9e1da82bf536ad5d85f02e35ca555476",
         intel: "3ac1a93ceb077f2f15988782416e7dc2bdbdc87d2477e48406a80233a2637b57"

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
