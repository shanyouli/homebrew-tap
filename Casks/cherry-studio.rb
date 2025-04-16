cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.4"
  sha256 arm:   "6670be956f4a0e02e22fda206fb3abec44bca6b822591ef32945ce57401e5caa",
         intel: "0e4a8d9a8eb750b36e4befc69c4900cd3717f139d4915c6d43609136214b5839"

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
