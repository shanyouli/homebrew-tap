cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.3.9"
  sha256 arm:   "5b800780001886c0ff7d5a5d9dd2ca624ad06d8ab789ef1e5b498cd95f0dbc8b",
         intel: "e23f974048cbbc2b5914791b824aedee225ac686c7ca0d9be310be16809572c5"

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
