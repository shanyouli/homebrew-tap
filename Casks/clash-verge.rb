cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.4.0"
  sha256 arm:   "48ecbcb5672abeb75926cd677f8de030fd8e51f0bff0fd5edf80ae350bc302c7",
         intel: "6e979429a3400ba9cca7a3afa5e9d50c9ea86ccb967d69d9056615d85e0b77a3"

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
