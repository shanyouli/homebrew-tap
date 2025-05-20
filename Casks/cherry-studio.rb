cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.3.6"
  sha256 arm:   "6430574105d54c561e93c017da5ac47160daf636fddfe84f7541cc77dbae6b2e",
         intel: "3017538ffc34c5814d1da8b2d3ec4c124cd0d6e1f24cbf645c3e0fed7b1a17eb"

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
