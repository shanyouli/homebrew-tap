cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.6"
  sha256 arm:   "94f79200f841b12aa767680ea82c6277710d192685c64af04e2f7b469f2e27b1",
         intel: "e704b11a3d562b45dd5e1a401f3de7189fc3a33fa5e55ada6aa5bff21e999466"

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
