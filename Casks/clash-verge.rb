cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.4.1"
  sha256 arm:   "60f839dc783889915b16bff6f92597352d63f8c0694286b4f2d491f59ae0c9d1",
         intel: "b2c8a502ede903ff72992d67cb75a77320e7f6cdb5d12f9bb9de9233cf8e9276"

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
