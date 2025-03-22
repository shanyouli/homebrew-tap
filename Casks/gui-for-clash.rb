cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.5"
  sha256 arm:   "afd75eac0b154f58bc93d105ac4da10fad3627aee11878aa0eec364251072794",
         intel: "528302634e8a79d7696907e687fb47f9370230f96c0f2d72845e7ec78afaa8d3"

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
