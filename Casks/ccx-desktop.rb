cask "ccx-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "2.9.37"
  sha256 arm:   "b1bbef19c8dcc688ffe15f3e7edfdc358fc8ca89445c3b2024d398d9d56f3f92",
         intel: "b2bb228a8f23c68db06d5e13ad95080af55e7cf4b8680bf7ab5a21aa8eda8c1e"

  url "https://github.com/BenedictKing/ccx/releases/download/v#{version}/CCX-Desktop-#{version}-darwin-#{arch}.dmg"
  name "CCX Desktop"
  desc "Multi-upstream AI API proxy and protocol conversion gateway"
  homepage "https://github.com/BenedictKing/ccx"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :catalina

  app "CCX Desktop.app"

  zap trash: [
    "~/Library/Application Support/ccx-desktop",
    "~/Library/Caches/com.ccx.gateway.desktop",
    "~/Library/WebKit/com.ccx.gateway.desktop",
  ]
end
