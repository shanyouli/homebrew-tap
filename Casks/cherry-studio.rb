cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.10"
  sha256 arm:   "add330f5d4ce4b9c5bbb9644f8d96fdc36e39f6fa0346a9f3d0ee05a1348c274",
         intel: "e44c62e00db62268100bf8023cec328fe310d099bc4cac7ea8b1075301edff9c"

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
