cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.23"
  sha256 arm:   "8ca754b2b374b97417cb0cfe885c3f8a75f035abddacacc0f060e355f73b40ef",
         intel: "4dddd595f3dec57baeeafe09d87520670463a1121966e8aab3cb0e23dc3c55a8"

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
