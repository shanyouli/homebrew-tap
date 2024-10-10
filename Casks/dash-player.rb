cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "4.3.1"
  sha256 arm:   "a1b91d5051c5987caa979d2b34eaa5acd511265ca64223966f8a2fb9c2e7cf45",
         intel: "68dde986c129a904da1a911e5186129d5d71dc435343d14aa657d4c7641364a9"

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
