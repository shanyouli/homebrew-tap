cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.5"
  sha256 arm:   "9561fcb7bbe23f80996c55fda66d2b158e1ba8f77b51e950b10913f1346fb899",
         intel: "7ee54aa196df542340d96453d6f689de650a883de1b85556ed24a7459488e6a1"

  url "https://github.com/kangfenmao/cherry-studio/releases/download/v#{version}/Cherry-Studio-#{version}-#{arch}.dmg",
      verified: "github.com/kangfenmao/cherry-studio/"
  name "cherry-studio"
  desc "支持多模型服务的GPT 客户端"
  homepage "https://cherry-ai.com/"

  livecheck do
    url "https://github.com/kangfenmao/cherry-studio"
    strategy :github_latest
  end

  app "Cherry Studio.app"

  zap trash: [
    "~/Library/Application Support/CherryStudio",
    "~/Library/Logs/CherryStudio",
    "~/Library/Preferences/com.kangfenmao.CherryStudio.plist",
    "~/Library/Saved Application State/com.kangfenmao.CherryStudio.savedState",
  ]
end
