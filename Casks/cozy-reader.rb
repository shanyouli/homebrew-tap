cask "cozy-reader" do
  version "0.1.19"
  sha256 "4327a0e8a434b32f723bbddde66481b2d72ec5196662dde30aca5d85403147c6"

  url "https://github.com/srsng/cozy-reader/releases/download/v#{version}/cozy-reader_#{version}_aarch64.dmg"
  name "cozy-reader"
  desc "一款轻量的阅读软件，仅支持 ePub 格式电子书"
  homepage "https://github.com/srsng/cozy-reader"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "cozy-reader.app"

  zap trash: [
    "~/Library/Caches/com.CozyReader.dev",
    "~/Library/Application Support/CrashReporter/cozy-reader_1EA4C51C-1E99-5395-A3A6-456A7C843B09.plist",
    "~/Library/Saved Application State/com.CozyReader.dev.savedState",
    "~/Library/WebKit/com.CozyReader.dev",
  ]
end
