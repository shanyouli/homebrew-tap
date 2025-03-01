cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.1.2"
  sha256 arm:   "9315c7c6fddf1cb2a3f2e1c13915b727578da410df625a8593675cb18e5beb04",
         intel: "2f08c76c00b3a172967fb69557e9bb5955f755a60ff044114f26e57bb167c33a"

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
