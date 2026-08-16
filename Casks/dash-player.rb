cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.3.1"
  sha256 arm:   "97f542aa67305e6df0d3de857ea162e42062636d022085c69f0df7debdfba8f9",
         intel: "11cff3be6c8dfa41746e36a4e594caa1e91b3d5fc9d35533034b013f35b36365"

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
