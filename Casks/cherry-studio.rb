cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.26"
  sha256 arm:   "b2390c0ee8142f3bde4de16b982846121a2e31eced747a2847d60e06e23be09a",
         intel: "bf5889303781332d1242e12d028edf34e5e7bdebd042a133ca985128111cdc34"

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
