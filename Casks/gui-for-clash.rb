cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.3"
  sha256 arm:   "232779ac6990e139b51e4f9d770452ef2ac0d686f879b4952abc0456e7bc6b7a",
         intel: "04fab1fd7b014043231ed30414c73f7fbf5d358cb77d47d998b2f026c7569407"

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
