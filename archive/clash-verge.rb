cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.4.6"
  sha256 arm:   "565cd085f8d6009edc2c8507c3eccc11574d7d04f73a19753555c5594a45e27a",
         intel: "1909acb3bb8eae97ff8907a04f523ec79800623a498dda6115bee49129c5d9a1"

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
