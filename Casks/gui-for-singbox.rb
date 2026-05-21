cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.24.1"
  sha256 arm:   "b0cc6e79d31d8ec279d9a2c6701ebf9816fcb27e5637600431ae49faa09f299c",
         intel: "f7412244c2b1f29a669bc152c34b10e1aca357de280b13bd512624a50e7f193b"

  url "https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/download/v#{version}/GUI.for.SingBox-darwin-#{arch}.zip"
  name "gui-for-singbox"
  desc "Singbox client"
  homepage "https://github.com/GUI-for-Cores/GUI.for.SingBox"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-(?:Alpha|dev)(?:(?:-|\.)\d+)?)?)$/i)
  end

  depends_on :macos

  app "GUI.for.SingBox.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.SingBox",
    "~/Library/Preferences/com.wails.GUI.for.SingBox.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.SingBox.savedState",
    "~/Library/WebKit/com.wails.GUI.for.SingBox",
  ]
end
