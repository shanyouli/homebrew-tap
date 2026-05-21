cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.4.6"
  sha256 arm:   "25514476a8d924001549e8cac2eefad82601b8e0742750506440153a1b5747f9",
         intel: "3a5dad960f1ac348208de55e230db1540ac626cebf948da0ad9e5e7b9bff8823"

  url "https://github.com/Hiram-Wong/ZyPlayer/releases/download/v#{version}/zyfun-mac-#{version}-#{arch}.dmg"
  name "zyplayer"
  desc "跨平台桌面端视频资源播放器,免费高颜值"
  homepage "https://github.com/Hiram-Wong/ZyPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "zyfun.app"

  zap trash: [
    "~/Library/Saved Application State/com.zyplayer.app.savedState",
    "~/Library/Saved Application State/com.zyplayer.savedState",
  ]

  caveats <<~EOS
    zyplayer 需要配合订阅源使用，可用订阅源地址如下: https://github.com/ls125781003/dmtg
  EOS
end
