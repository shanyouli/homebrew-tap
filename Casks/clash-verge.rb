cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.2"
  sha256 arm:   "efa6294c625bd9dd19cf8b744df0fcf49b8eb1a8655bb0e53e7cea9bb0f4e10b",
         intel: "b7e8152d082c780f9ed2e428b21de2908ab9050eeb3b46f8f787fbbd602a5f14"

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
