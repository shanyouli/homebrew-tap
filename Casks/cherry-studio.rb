cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.0.6"
  sha256 arm:   "e617c5d0055ab31f282dacf95a2b33d06dad43d3c980b0c5c63514a34cfe84de",
         intel: "3cb05f58924da2f940447c35e01283becc115eabc4b49de58434ec3412ff7c51"

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
