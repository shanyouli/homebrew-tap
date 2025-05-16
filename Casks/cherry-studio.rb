cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.3.4"
  sha256 arm:   "5045298ce8e80979476fea18ec3d9ead91d316c474cf2da8617ec6ea51483231",
         intel: "7609c5b3cb62a71e269122f7c19dece4462a433e4affa4ba1d6f010f66284323"

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
