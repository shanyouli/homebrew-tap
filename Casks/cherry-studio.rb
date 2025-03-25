cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.1.10"
  sha256 arm:   "332fa1f31ccd1ccfac1b33650bffd9de5230e546c278dc2b958ddfc31bea14ad",
         intel: "34b1c0d418781cc206cb6a5789b59bff9f0ebbf99fcd82c473c29a9f2bf6c2e1"

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
