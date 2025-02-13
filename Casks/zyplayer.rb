cask "zyplayer" do
  arch arm: "arm64", intel: "x64"

  version "3.3.10"
  sha256 arm:   "5c6380ed331abeed8e582ee630ddd6fb52b660d821ca7b4fa7aee9ad1df442d3",
         intel: "6ca72fbb1e504e6fb2d0eb7b39952eae7492fe9e4af5fe70f0f76286b207d38e"

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
