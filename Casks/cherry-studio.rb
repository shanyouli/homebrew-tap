cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.17"
  sha256 arm:   "f870a1e98d88dc8a0cfe4386f8b4e18aae073711e94d5d64e458b82c0b86b267",
         intel: "5d4e9992c7c04c337591182ba29742bca79e3c33a1b7b6d8329e17e57e235902"

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
