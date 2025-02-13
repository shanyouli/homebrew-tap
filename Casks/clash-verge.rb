cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.3"
  sha256 arm:   "7574f7c18deaf644464d36bdfc17283865a1a895970ee8571fae96556e787785",
         intel: "175052d306c5f7f6f569c239f8349524d5c944f3dde23ecd744b1675c04a9a20"

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
