cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.1"
  sha256 arm:   "7ce4f9cc85a1db7954fb813e59fc2d6a3fd23b1d9ffa5debd504e04bf50c5938",
         intel: "ce93b639db92f363575dc9ad95afa39452d0edc58fe0486516591dd52febdc7d"

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
