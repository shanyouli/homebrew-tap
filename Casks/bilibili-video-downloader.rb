cask "bilibili-video-downloader" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "31a396c3f8e3398154f2ee976182056516aa656af3e368115addfaf8baf4266a",
         intel: "c9fd86f70bffa441da9babae8fcd462cd841c2d543b0d85d29970b197ac0d0d6"

  url "https://github.com/lanyeeee/bilibili-video-downloader/releases/download/v#{version}/bilibili-video-downloader_#{version}_macos_#{arch}.dmg"
  name "bilibili-video-downloader"
  desc "Bilibi video download"
  homepage "https://github.com/lanyeeee/bilibili-video-downloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "bilibili-video-downloader.app"

  zap trash: [
    "~/Library/Application Support/com.lanyeeee.bilibili-video-downloader",
    "~/Library/Caches/com.lanyeeee.bilibili-video-downloader",
    "~/Library/Preferences/com.lanyeeee.bilibili-video-downloader.plist",
    "~/Library/WebKit/com.lanyeeee.bilibili-video-downloader",
  ]
end
