cask "cherry-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.8.5"
  sha256 arm:   "2acbe919820f043af583280f79c3ec6beb96abb2f35c5c34fd0dade5aa73f498",
         intel: "4d5af80ffb719e000a30db84081912e192cf392adebc3035df86acbba675f47b"

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
