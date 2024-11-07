cask "nextchat" do
  version "2.15.7"
  sha256 "ad8fe4dca9437c837f46b1da43973b8d9393412a5d5a45a534b3e6b7ddb5f1ca"

  url "https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web/releases/download/v#{version}/NextChat_#{version}_universal.dmg"
  name "NextChat"
  desc "Cross-platform ChatGPT/Gemini UI"
  homepage "https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "NextChat.app"

  zap trash: [
    "~/Library/Application Support/com.yida.chatgpt.next.web",
    "~/Library/Caches/com.yida.chatgpt.next.web",
    "~/Library/Preferences/com.yida.chatgpt.next.web.plist",
    "~/Library/WebKit/com.yida.chatgpt.next.web",
  ]
end
