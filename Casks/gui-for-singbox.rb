cask "gui-for-singbox" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.5"
  sha256 arm:   "f1bfd08d6be188b0839cd681c39594d11a823c12ff53b13a62a959409461ddb8",
         intel: "66bb3fc9592836ec1af14b119337c418221a40fd5778d5a87b16cbda6c0735e1"

  url "https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/download/v#{version}/GUI.for.SingBox-darwin-#{arch}.zip"
  name "gui-for-singbox"
  desc "Singbox client"
  homepage "https://github.com/GUI-for-Cores/GUI.for.SingBox"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.SingBox.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.SingBox",
    "~/Library/Preferences/com.wails.GUI.for.SingBox.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.SingBox.savedState",
    "~/Library/WebKit/com.wails.GUI.for.SingBox",
  ]
end
