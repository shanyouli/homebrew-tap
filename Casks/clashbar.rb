cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.3.0"
  sha256 arm:   "4f586c168ab44125dbc8377dec6c7d058af5dffef80869a3afac60f26201741e",
         intel: "2bed157a12908fc8977d1505b03f517c1a488886397425bfab6fd9e0cfb3aea2"

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
