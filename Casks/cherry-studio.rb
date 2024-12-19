cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.27"
  sha256 arm:   "c0c0285441750af7eb41f274d002b2d4b61b53efbe7c8b4b84f86c0c3ab05d45",
         intel: "2984a0f75b4e434fe71d9badebc2d27620650ba1ef3a33e86a82042045481ccf"

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
