cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "1.7.7"
  sha256 arm:   "f01c56e4612691b066eedddcc22177efdd1e486e06b38cd5ab5ebc3d76329ada",
         intel: "ddf94bb368ef086ffd71513f0bf793bdbebd1c9aba94d7ac20f5fa722f05b004"

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
