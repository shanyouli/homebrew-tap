cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.17"
  sha256 arm:   "7d8feaa5638447d8233758eb15a9843af2c5a1d25a0cbeacad71faa5cf76a228",
         intel: "c1c4341e91921da517176e30d7429a3afbc994bc8ad345c1cfab8c0d79b01c1f"

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
