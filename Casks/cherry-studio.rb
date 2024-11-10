cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.10"
  sha256 arm:   "43d6e6b2950bdc6313ab6fc115f8683e1940be1b5e95277329cafd6c790cfb22",
         intel: "2342784d1c08a1f97275828346f2a6d15b9b71fb7a0045b5493e0be890fbfbc3"

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
