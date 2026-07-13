cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.3.1"
  sha256 arm:   "30d3a66a39a51b13673cf88f5961a19bba3045ebe4a984637a12c30a1926a493",
         intel: "4e2d01b864c565a6cca971263674cd3b0a98b765acf5f7ca80d232c7b611e1bd"

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
