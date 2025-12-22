cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "2.4.4"
  sha256 arm:   "17587f4ae565f8a4007f69aa91f16d90e54d8e2a06ff18074213c9fd1757221f",
         intel: "579365fbf503e7a7bc30904fa3e2c27262cdb47102e8fbfed1b7873b735ce7c6"

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
