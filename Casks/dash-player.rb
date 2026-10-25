cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.14.0"
  sha256 arm:   "1499bf16c2be21b1f8642019b2964a855c75af0c78d5b82d77e345dd01f5708e",
         intel: "41b01e9fb3e394b40a58abc1dfbce4ed1cbe8e8c6c6193ce92041ca038e77d1a"

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
