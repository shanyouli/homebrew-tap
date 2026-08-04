cask "bilibili-video-downloader" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.1"
  sha256 arm:   "aba9650700249f9927e152dea98dd2df9644a7b2498173812cb7034363b59240",
         intel: "3edafe199eee45dedf3228a6a236416590c362611f1b783ca602a8d1094a4310"

  url "https://github.com/lanyeeee/bilibili-video-downloader/releases/download/v#{version}/bilibili-video-downloader_#{version}_macos_#{arch}.dmg"
  name "bilibili-video-downloader"
  desc "Bilibi video download"
  homepage "https://github.com/lanyeeee/bilibili-video-downloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "bilibili-video-downloader.app"

  zap trash: [
    "~/Library/Application Support/com.lanyeeee.bilibili-video-downloader",
    "~/Library/Caches/com.lanyeeee.bilibili-video-downloader",
    "~/Library/Preferences/com.lanyeeee.bilibili-video-downloader.plist",
    "~/Library/WebKit/com.lanyeeee.bilibili-video-downloader",
  ]
end
