cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "1.2.10"
  sha256 arm:   "859dd85a77536954a24a7456d1b8e52d9dfad03c6306b370c95e672d03cf4979",
         intel: "efe3adcd4cead37b9614b5e1fb3c1965a6bc243eefa0a4572dc37d818a34eca2"

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
