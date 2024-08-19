cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "1.7.6"
  sha256 arm:   "cd1a160e8fb7b12944b01a8925fdf2991241b493b05d1f61666c3de95d48a155",
         intel: "28b0f232c5003ef609896f44b4fb9e73f3e47dfd86f27c69062f9eb949dd2ee2"

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
