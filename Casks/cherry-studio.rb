cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.1"
  sha256 arm:   "929fe923768e14cf3d1874bb0d9a9c4f5bbd86b2b05bbd5a5a770daa87a975d0",
         intel: "3e0f059fc7224c26fa80ce56a9ac6bf1180235fa66c0d386885ae00ad75dd324"

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
