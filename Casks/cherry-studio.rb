cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.3.9"
  sha256 arm:   "6a0e0e3229fdf1b810fd506b526f0800a4938047e52a59aae4ae31236e91bd58",
         intel: "76f87356a2acb823f1de92cba3393949745840574813e9188954a09dc5b13052"

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
