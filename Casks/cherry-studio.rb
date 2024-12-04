cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.20"
  sha256 arm:   "79b006fcc22848f2ba191114ad742e80a95bc4fab476ab93e31f6c9921bcd650",
         intel: "3556c6f40f892f0f1c2b34e2168c2b9ab2d46f1722d3b93ee5a44f3a2c07dbfd"

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
