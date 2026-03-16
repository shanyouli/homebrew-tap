cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.4.3"
  sha256 arm:   "34cb7eac7073c1c621813c02439df559926a31849905ebfdb84fa934e3a0be2c",
         intel: "28b3d2e4f5300db3ab6a7ef1a9c8b1304bccf2ce3aa373b59ab415d3849398e2"

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
