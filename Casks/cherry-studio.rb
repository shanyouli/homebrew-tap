cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.27"
  sha256 arm:   "d4a2b9fd8394468cbb0a7b4f8c5540796d7bf2e9c427dd93618d8e682beb33b8",
         intel: "46bed4a003ff9a11e27678d1a693c1fea4b4210eb1422d3faa79dbdaa305f5e5"

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
