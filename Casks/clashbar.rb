cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.3.6"
  sha256 arm:   "f25bd38eca4992292535675458a1260c8a5af32b5d7ffd83f3c78869fa48cc19",
         intel: "f2ab4eaf1720c418e18132ef2d6b0dc5417b89ca2165251a201a7e46f3a57716"

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
