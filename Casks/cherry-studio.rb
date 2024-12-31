cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.3"
  sha256 arm:   "ef97ff1eb78a650042306ff84ae3f402357a769238c9e923da857ccf1c2802d3",
         intel: "f432ade7c3759c5fe69bb3d4320d220213185575ccb0f8856f191df626a7befb"

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
