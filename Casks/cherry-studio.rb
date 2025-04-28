cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.9"
  sha256 arm:   "3d706249f562564b3fd15a25cd7fea5dbc26a9a10447c0c89a8c8fa50388c6b4",
         intel: "8cddb3673be954d5a8a21ea3ecdb655421aab2334e28f9c3096029bc928fc106"

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
