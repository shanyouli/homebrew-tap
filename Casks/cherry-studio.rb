cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.1.18"
  sha256 arm:   "29403b1f7cf9b29ab8e2345b555d990db15c33aa51fb6973113c1f723228445a",
         intel: "b437a4521689f3e13378cf1a0c29acdfed01e20b3dd1250ffb7e5e35edca2ae0"

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
