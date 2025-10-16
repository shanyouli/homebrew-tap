cask "gui-for-clash" do
  arch arm: "arm64", intel: "amd64"

  version "1.13.0"
  sha256 arm:   "7bd2ed29c74e415b910bfcf028f9a07f6b349b99b28486e8f17b99bf99cfa62b",
         intel: "106b83afde05ea3146bdcbeb2f7c3a189ed4dd6590814d143c2fd6e08d3825dd"

  url "https://github.com/GUI-for-Cores/GUI.for.Clash/releases/download/v#{version}/GUI.for.Clash-darwin-#{arch}.zip"
  name "gui-for-clash"
  desc "GUI program developed by vue3 + wails"
  homepage "https://github.com/GUI-for-Cores/GUI.for.Clash"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-Alpha(?:-\d+)?)?)$/i)
  end

  app "GUI.for.Clash.app"

  zap trash: [
    "~/Library/Caches/com.wails.GUI.for.Clash",
    "~/Library/Preferences/com.wails.GUI.for.Clash.plist",
    "~/Library/Saved Application State/com.wails.GUI.for.Clash.savedState",
    "~/Library/WebKit/com.wails.GUI.for.Clash",
  ]
end
