cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.17.0"
  sha256 arm:   "f2c88657e1832700c7d1784cf207fd26e556decc338923f220ebd4feb4afb7f7",
         intel: "f9122bc91303add5c5336ed998b1fb07d77e86c6ef603d74564ef7a54427e9c0"

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
