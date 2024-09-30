cask "snapbox" do
  version "1.11.1"
  sha256 "09b8f01d0bf38482970b37931297c66718eb75371436d652110ee7f77d83456e"

  url "https://github.com/xinxiaotech/snapbox-release/releases/download/app-v#{version}/Snapbox_#{version}_aarch64.dmg",
      verified: "github.com/xinxiaotech/snapbox-release/"
  name "Snapbox"
  desc "AI reactions instantly from your friendly local LLaMA"
  homepage "https://snapbox.app/"

  livecheck do
    url "https://github.com/xinxiaotech/snapbox-release/"
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "Snapbox.app"

  zap trash: [
    "~/Library/Application Support/app.snapbox.desktop",
    "~/Library/Caches/app.snapbox.desktop",
    "~/Library/Saved Application State/app.snapbox.desktop.savedState",
    "~/Library/WebKit/app.snapbox.desktop",
  ]
end
