cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.1"
  sha256 arm:   "ebd12ce0c136d364dbe9a4747089f3e13a877df69c8aa0f7f803b39886153d35",
         intel: "b5c844cde4fcd02671b06ce394f02f6b7acb9e96c45bc1b4629c10d7b3734768"

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
