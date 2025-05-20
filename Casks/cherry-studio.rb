cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.3.8"
  sha256 arm:   "9f29b67ef3f0a2c751893ce6da7fc95a15f86f3ffb60e4ebaf8ec17b6e5c6474",
         intel: "4fb97f8afa86b1020bc67dff83cef20a524b492964e38cc7ed1e5d76115e274a"

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
