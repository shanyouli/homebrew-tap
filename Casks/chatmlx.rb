cask "chatmlx" do
  version "1.1.3"
  sha256 "0ae206954b46e9c214e584152a6c09b94cd8d5b839a5815fc14ab265fdef05fe"

  url "https://github.com/johnmai-dev/ChatMLX/releases/download/#{version}/ChatMLX.#{version}.dmg"
  name "chatmlx"
  desc "Modern open-source high-performance chat application"
  homepage "https://github.com/johnmai-dev/ChatMLX"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "ChatMLX.app"

  zap trash: [
    "~/Library/Application Scripts/johnmai.ChatMLX",
    "~/Library/Containers/johnmai.ChatMLX",
  ]
end
