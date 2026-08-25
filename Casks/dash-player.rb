cask "dash-player" do
  arch arm: "arm64", intel: "x64"

  version "6.5.0"
  sha256 arm:   "20bd9e5ded0f58cee368eb2da8f1270b69e8516dceed54da62795d40c830c392",
         intel: "b839bd0bf7479152025718af3ce8bf11ed5581cae624f4e014363d7a09877ce5"

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
