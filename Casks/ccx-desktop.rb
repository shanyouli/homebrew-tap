cask "ccx-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "2.8.26"
  sha256 arm:   "93928f629bc8a7216b50d6512c34897f11bd20db986d614758821f3eee408b40",
         intel: "1c7517d81f59ad1a45de9b8738d0ed20db9bfc7927595f7f918c40e60c6352ad"

  url "https://github.com/BenedictKing/ccx/releases/download/v#{version}/CCX-Desktop-#{version}-darwin-#{arch}.dmg",
      verified: "github.com/BenedictKing/ccx/"
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
