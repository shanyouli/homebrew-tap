cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.4.2"
  sha256 arm:   "57b08e9f254bb1a35c1c7afc88af57d9add96a952b15abd0c7dc9c62b1288e66",
         intel: "1a4ea5ef2ba36bdffac08d4a3831f260fd951bb628504cfdc1528daf2fe43c91"

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
