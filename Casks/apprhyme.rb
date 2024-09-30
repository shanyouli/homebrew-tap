cask "apprhyme" do
  version "1.0.9"
  sha256 "796fe78d6918799799082c98462048743890761d75ff1132b8d714741f7047c6"

  url "https://github.com/canxin121/app_rhyme/releases/download/v#{version}/AppRhyme-release-macos-unknown-#{version}.dmg"
  name "apprhyme"
  desc "使用 Flutter 和 Rust 构建的开源免费音乐软件"
  homepage "https://github.com/canxin121/app_rhyme"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "AppRhyme.app"

  zap trash: [
    "~/Library/Application Scripts/com.canxin.AppRhyme",
    "~/Library/Containers/com.canxin.AppRhyme",
  ]
end
