cask "spacepreview" do
  arch arm: "arm64", intel: "x64"

  version "0.10.22"
  sha256 arm:   "8de041a9e1994a838ddf7b97e10340c383ae060f1dfe8db73f8f2d5b3ad8834b",
         intel: "e8a1f18c54729794d4fea19040deaeb5cbb93c63b4e97d76bf2f3c4b23042bee"

  url "https://github.com/likehao19/SpacePreview/releases/download/v#{version}/SpacePreview-#{version}-macos-#{arch}.dmg"
  name "SpacePreview"
  desc "Quiet, local-first file previewer for documents, images, code and archives"
  homepage "https://spacepreview.likh.cn/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "SpacePreview.app"

  zap trash: [
    "~/Library/Application Support/com.spacepreview.desktop",
    "~/Library/Caches/com.spacepreview.desktop",
    "~/Library/LaunchAgents/SpacePreview.plist",
    "~/Library/Preferences/com.spacepreview.desktop.plist",
    "~/Library/Saved Application State/com.spacepreview.desktop.savedState",
    "~/Library/WebKit/com.spacepreview.desktop",
  ]

  caveats <<~EOS
    The app is ad-hoc signed and not notarized yet: the first launch may be
    blocked by Gatekeeper. Right-click the app and choose Open, or allow it
    under System Settings > Privacy & Security.
    Reading the selection from Finder/QSpace Pro needs Accessibility and
    Finder Automation permissions, which must be granted manually on first use.
  EOS
end
