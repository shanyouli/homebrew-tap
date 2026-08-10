cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.2.0"
  sha256 arm:   "7db3f4b3e8141ca714674610eaffaff31f632c3f692a3ca94a3d0af269f42222",
         intel: "bf6e663899fdd1f21d2e12cbbc65c3d01ce04db66dd86871fbfdbbe05401b3f7"

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
