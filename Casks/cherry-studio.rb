cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.19"
  sha256 arm:   "0b678714213e8cee321d348fa47d6cdfdc8d58ac141117849a97c2048ed4a06e",
         intel: "b5259edbf144c962b2b3007abbc02653af05f84e739f71f4b5db070713129c11"

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
