cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.4.0"
  sha256 arm:   "7f40d460a3fff674216c5d1f6485dfa9e059d3e5908a3d3f92833baebaf862d2",
         intel: "ff355905663e048e79c627aceadc6969a7d56d32af0b0e554ebe27662139e5ad"

  url "https://github.com/Hiram-Wong/ZyPlayer/releases/download/v#{version}/zyfun-mac-#{version}-#{arch}.dmg"
  name "zyplayer"
  desc "跨平台桌面端视频资源播放器,免费高颜值"
  homepage "https://github.com/Hiram-Wong/ZyPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "zyfun.app"

  zap trash: [
    "~/Library/Saved Application State/com.zyplayer.app.savedState",
    "~/Library/Saved Application State/com.zyplayer.savedState",
  ]

  caveats <<~EOS
    zyplayer 需要配合订阅源使用，可用订阅源地址如下: https://github.com/ls125781003/dmtg
  EOS
end
