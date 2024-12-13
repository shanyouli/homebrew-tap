cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.25"
  sha256 arm:   "2ab21d96d8cba19f1349f591645ecfe7c33b9f1b00b6b3d30eca1ffe7053c959",
         intel: "302ba739bc9cba9e30cc24095752e961428e9c9102b4db7158b81d8f1a8bb256"

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
