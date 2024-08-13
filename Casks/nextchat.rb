# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "nextchat" do
  version "2.14.1"
  sha256 "13a4f0ec1a5b2d29f9b042e8e759412b55d92239d9631ff685600405b5a5a322"

  url "https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web/releases/download/v#{version}/NextChat_#{version}_universal.dmg"
  name "NextChat"
  desc "A cross-platform ChatGPT/Gemini UI"
  homepage "https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url :url
    strategy :github_latest
  end

  # depends_on macos: ""

  app "NextChat.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/Caches/com.yida.chatgpt.next.web",
    "~/Library/Application Support/com.yida.chatgpt.next.web",
    "~/Library/Preferences/com.yida.chatgpt.next.web.plist",
    "~/Library/WebKit/com.yida.chatgpt.next.web"
  ]
end
