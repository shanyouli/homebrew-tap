cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.4.4"
  sha256 arm:   "ea897fa4650e1a64c02e8e9390523aced88884ebe050a74682f876bf665abd54",
         intel: "24e5beb54821c8ea9d5bb7025fd96a24f86bc450619f42a1e155852a0377b66a"

  url "https://github.com/Hiram-Wong/ZyPlayer/releases/download/v#{version}/zyfun-mac-#{version}-#{arch}.dmg"
  name "zyplayer"
  desc "跨平台桌面端视频资源播放器,免费高颜值"
  homepage "https://github.com/Hiram-Wong/ZyPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "zyfun.app"

  zap trash: [
    "~/Library/Saved Application State/com.zyplayer.app.savedState",
    "~/Library/Saved Application State/com.zyplayer.savedState",
  ]

  caveats <<~EOS
    zyplayer 需要配合订阅源使用，可用订阅源地址如下: https://github.com/ls125781003/dmtg
  EOS
end
