cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.7"
  sha256 arm:   "0d5828c169bfbf74514bd860d2179ff1666a359d19703c8426f2908d3642fed1",
         intel: "484e6021e33f9c234e27ce518c605a6f2eaa936349abcd09cfc7dbc10b0a5ab7"

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
