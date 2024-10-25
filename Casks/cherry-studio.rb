cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.4"
  sha256 arm:   "b167e429644b2b34ebc666fda1961dcd81f09e7484469c00f7f8e90f1e5a9967",
         intel: "67ba214d05b1fefc5002167eb7f0b9bd9b94de2a00f971c7e20a17b616b0b24d"

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
