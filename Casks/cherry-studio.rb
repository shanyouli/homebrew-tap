cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.9.24"
  sha256 arm:   "6a0baa5213458e761bed2cfd8c2cab036562186e4be45d3bed290352250039e9",
         intel: "a3cc26ba8e8c290ca33b270030d4e6c44b4c40bb9a9eb154e0b1946ef4bfd1f5"

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
