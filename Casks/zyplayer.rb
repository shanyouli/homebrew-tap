cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.4.7"
  sha256 arm:   "197bfc912a8717d445a5c2929964992eb2149b45545aa6ef7aa23170a3487be5",
         intel: "190461e0c7eaec1740adfbc0184bc4fc8966e19da65ef64f9c16b449ebe45a5f"

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
