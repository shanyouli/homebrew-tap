cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.0.1"
  sha256 arm:   "d967bdd6651455b44469c481087de8c8b1ece7880ec0904ca1a8cc129429c758",
         intel: "17fb2df4a8a07a29ab882c85ccdfd4c1e126ca7ceb6e2432c1b6585b6b7dc1d3"

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
