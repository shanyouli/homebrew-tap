cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.9"
  sha256 arm:   "7018369bce70e2085ebc466ceb817711c6ef6252999082d4705cf30a30311dbf",
         intel: "7c09b0c978c60d59a4954301cbb08a808902b0519f2130ba5f7818a322c750e4"

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
