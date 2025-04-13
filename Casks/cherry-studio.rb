cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.2"
  sha256 arm:   "09a9d7dde176684a7fb7495baab7fd527189abadd23e8f18150227dbf96f917f",
         intel: "0e10df42520dcdca2886ac7072224efa82e966179ab1ce00f83eb023f61e5530"

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
