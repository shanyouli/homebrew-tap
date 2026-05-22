cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.2.6"
  sha256 arm:   "4e3b8187b63e9405d47ef043fcf720ba34970736a6770bc4562c63417689a183",
         intel: "ce5d0c1f09c5c24c5b80c265e3ae14b06aba2a98ad0480622e035b6936381c92"

  url "https://github.com/Sitoi/ClashBar/releases/download/v#{version}/ClashBar-#{version}-#{arch}.dmg"
  name "clashbar"
  desc "基于 SwiftUI + AppKit 构建 clash 客户端"
  homepage "https://github.com/Sitoi/ClashBar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "ClashBar.app"

  zap trash: [
    "~/Library/Application Support/clashbar",
    "~/Library/Preferences/com.clashbar.plist",
  ]
end
