cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.4.2"
  sha256 arm:   "ed190ea74884319d1293b04be80fdbe2b878e955461444e245a98f3b8f308df4",
         intel: "52b18a97c4c14e5ca183a9197b01e1250fd6d83873849b971fac43c3a6311d86"

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
