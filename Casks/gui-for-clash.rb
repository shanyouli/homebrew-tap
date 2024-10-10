cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.7"
  sha256 arm:   "795c82296157957732504cb8fb1525067b611a3bf542e1926b9756ea2eb0a30c",
         intel: "0002b29d803fed5d793d9faa45e1747221cf88e37c13bebe721b38f35ab42304"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
