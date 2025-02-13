cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.23"
  sha256 arm:   "c78c0e5731e58fc5b1bce8d72246070fbd0735830f882a5f65717af94673f95d",
         intel: "ebf72d0edc2873ba1afae8b2588ad1d778ac8356b6d8b104d450e55463ff638b"

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
