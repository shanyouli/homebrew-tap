cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.14"
  sha256 arm:   "ff1e6b675f735d70e47be836dd361e39305051ae0f592aab702d7ce8f226f588",
         intel: "519ca7f8de571743c493f878383d90cde83cf41e364f28c6e084e39bb2921fbf"

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
