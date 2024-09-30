cask "snapbox" do
  version "1.9.9"
  sha256 "95bb2a27be08306c2f503d1e1136ec9be59ccc5bc7bc295c588fd2969a4f34c4"

  url "https://github.com/xinxiaotech/snapbox-release/releases/download/app-v#{version}/Snapbox_#{version}_aarch64.dmg"
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
