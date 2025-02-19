cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "5.1.3"
  sha256 arm:   "95d635140b7293ecc44afa337a0c4f4e3cf64b2a9fe2dfa47933e6685d7b3313",
         intel: "481be81af085d232fc0e4404a8c71c59e7c8e1c7370adfe39385e2fbaeb0716a"

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
