cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.13"
  sha256 arm:   "a8660a7e544bd6d79ec85d17055d1dd5d1c9b624f403d260e3f67fddbbeef5ea",
         intel: "c576fe740d06410262ff513f512c2648d1222aad5a487fdb966ae6b7db8410bf"

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
