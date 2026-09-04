cask "clashbar" do
  arch arm: "apple-silicon", intel: "intel"

  version "0.3.3"
  sha256 arm:   "ff8ca07ce4ee6780fce19d620292b45b85667a92b1e12c6bffc0c213d0a4680c",
         intel: "181d2172a837fcecd5e7cce7c40e59c845144b25c2628d22018377e721ec6c8a"

  url "https://github.com/Sitoi/ClashBar/releases/download/v#{version}/ClashBar-#{version}-#{arch}.dmg"
  name "clashbar"
  desc "基于 SwiftUI + AppKit 构建 clash 客户端"
  homepage "https://github.com/Sitoi/ClashBar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "ClashBar.app"

  zap trash: [
    "~/Library/Application Support/clashbar",
    "~/Library/Preferences/com.clashbar.plist",
  ]
end
