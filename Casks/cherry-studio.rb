cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.4"
  sha256 arm:   "5ef754b154a187d110963b046c02b8578922117d1739e85580eed58460138b65",
         intel: "a61e479ee94d2e23c5d4ccac0ae999d513d49a2470aaddf38251116c7e1113a8"

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
