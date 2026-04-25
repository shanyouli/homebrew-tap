cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"
  version "0.2.3"
  sha256 arm: "45787def05fb2e1669e60efc041e79d52f0ce2d14c13b7e61d9468d25f730590",
         intel: "15d9576149670beeb352ab15373b0175921348fc4e5987c4afc169e550624276"

  url "https://github.com/Sitoi/ClashBar/releases/download/v#{version}/ClashBar-#{version}-#{arch}.dmg"
  name "clashbar"
  desc "基于 SwiftUI + AppKit 构建 clash 客户端"
  homepage "https://github.com/Sitoi/ClashBar"
    livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "ClashBar.app"

  zap trash: [
    "~/Library/Application Support/clashbar",
    "~/Library/Preferences/com.clashbar.plist"
  ]
end
