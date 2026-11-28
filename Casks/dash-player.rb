cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.22.0"
  sha256 arm:   "0b75779a6533a1cb665161c19d093469be89cc886ecc0d1e7b4de112e116a38d",
         intel: "f2b915f65463a2b69c13075d3472cb0799e80a868315d6e9db9c414a3e5c97dd"

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
