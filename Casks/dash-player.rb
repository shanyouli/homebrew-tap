cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.16.0"
  sha256 arm:   "eaad166ec8e0f7f05e936a09f3e7fa87d5aed0c047d5a94d93076ae8b9a51ed7",
         intel: "638bea2cdd8da5f355d80c0077318a6afeb530f2a223fb792420250acc2433e1"

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
