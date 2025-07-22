cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.3.2"
  sha256 arm:   "5a11e6a3b3a4dc2aa0fb68b153af735537c2c09a2f73958c0358db4ad2b0d7a8",
         intel: "1ffd35719717bd2e797e2bf4aff8149d8647fc5330dc17deac83e084e9d25fc7"

  url "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v#{version}/Clash.Verge_#{version}_#{arch}.dmg"
  name "clash-verge"
  desc "Clash Meta GUI based on Tauri"
  homepage "https://github.com/clash-verge-rev/clash-verge-rev"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Clash Verge.app"

  zap trash: [
    "~/Library/Preferences/top.gydi.clashverge.plist",
    "~/Library/Saved Application State/top.gydi.clashverge.savedState",
    "~/Library/WebKit/top.gydi.clashverge",
  ]
end
