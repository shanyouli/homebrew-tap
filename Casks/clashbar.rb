cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.2.7"
  sha256 arm:   "f730a7e84caffa24e34d8f110fc558a5d6ef5d9bc3a8de327cca3e78b2667612",
         intel: "6c57fdb5bb9cbb6e8bdfabbfc35642f8d1b7cbea4d4eeaeaae9d5c68b3c1c805"

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
