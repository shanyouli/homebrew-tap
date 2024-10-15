cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.0"
  sha256 arm:   "e59f7f777441396d451a6e524747867cd24895e275f4f1aa9fa0fee3a1992668",
         intel: "bcb95a2949c5054ac7e227401185cc52b0bc5d4ad5974bb182406e24e0fb9cb1"

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
