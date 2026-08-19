cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.3.2"
  sha256 arm:   "3365f66fbb70f2c5b694fb5491c088ee42c89b9ca2022cce0681057adaa45deb",
         intel: "214b9f74584838a368acfaaa3930f35aeea20d4f0edd39d5bcf0bf7befd02dc1"

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
