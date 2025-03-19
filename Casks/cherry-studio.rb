cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.1.7"
  sha256 arm:   "c072f021f768c9c3767050b3c2cc839ba2a5c7d12899daa03cd70a509f1a68a9",
         intel: "58213bac522539c4a07b09bc1569bfde8cd43032059e4d7d3652fc774259d0b0"

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
