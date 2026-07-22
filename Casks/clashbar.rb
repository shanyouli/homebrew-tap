cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.3.2"
  sha256 arm:   "a8d57f180a5bee6fe3f92483315a604c6f16cf0ff75f7ed2d481c63bfe1eb458",
         intel: "dbeace24196e25fb4165edda811c4529618c87c03ba472fae6711eaec6fc2856"

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
