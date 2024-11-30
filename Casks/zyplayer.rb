cask "zyplayer" do
  arch arm: "arm64", intel: "x64"
  version "3.3.7"

  sha256 arm: "d85b75ef3091cd65ce701cff7248072e102047483eed67f3d0a26b70d5eaa363",
         intel: "de5ffc3f25eecb3fa7b64b566e67c9c0c3ddb31e436b66c14a12f20231ae7bec"

  url "https://github.com/Hiram-Wong/ZyPlayer/releases/download/v#{version}/zyfun-mac-#{version}-#{arch}.dmg"
  name "zyplayer"
  desc "跨平台桌面端视频资源播放器,免费高颜值."
  homepage "https://github.com/Hiram-Wong/ZyPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "zyfun.app"

  zap trash: [
    "~/Library/Saved Application State/com.zyplayer.savedState",
    "~/Library/Saved Application State/com.zyplayer.app.savedState",
  ]
  caveats <<~EOS
    zyplayer 需要配合订阅源使用，可用订阅源地址如下: https://github.com/ls125781003/dmtg
  EOS
end
