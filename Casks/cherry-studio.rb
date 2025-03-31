cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.1.17"
  sha256 arm:   "636d44d417c2a9bd5bf949c6da4e4e79f8a7b4ecf0f0922af59b1d6a6762b7c0",
         intel: "6135121a19a5e89be96786106a62b834e72c38523772b0ff3386a96f8e7e3534"

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
