cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.0.4"
  sha256 arm:   "9fe678849b5fe27cbc032d5e66661125b0197a767f84c9340109c8849e3581aa",
         intel: "22b326f7a7db23725101cf54786499111faabf54944ec719e0c83d06cf3cfa5c"

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
