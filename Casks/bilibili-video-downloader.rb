cask "bilibili-video-downloader" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "579ba91d7d12a522e6f205bd920246ac7d0921bfc417c402abf8233383373e1a",
         intel: "ef8626b190c4d042b86d256590af9d44b5cb55936dfeeeca22caef74a7f579fe"

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
