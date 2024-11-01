cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.7"
  sha256 arm:   "a7f85de27f1f63647a43fdebaa7f0974af5d48f598c74c271c0607dbb1e6f137",
         intel: "6b62037a5eaeba2b08f9aa183f74af90165a169c6b16bac5faaa8a4f716a15c9"

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
