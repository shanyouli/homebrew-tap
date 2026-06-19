cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.2.8"
  sha256 arm:   "5aef2203fcd19b226340c5b5a9b5b7e72957ea1d16bd4ce630850037eed9cd1f",
         intel: "1dda0e0241103810cb9ea1077a19627e2fb6e70f1a6978adcf5f76fbc5c43e89"

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
