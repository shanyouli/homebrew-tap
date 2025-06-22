cask "readest" do
  version "0.9.59"
  sha256 "ab61d0df37be9d79510c72de371472fb65eee4d771920278af7a1f9692febbcd"

  url "https://github.com/readest/readest/releases/download/v#{version}/Readest_#{version}_universal.dmg"
  name "readest"
  desc "Modern, feature-rich ebook reader"
  homepage "https://github.com/readest/readest"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Readest.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/Application Support/com.bilingify.readest",
    "~/Library/Caches/com.bilingify.readest",
    "~/Library/WebKit/com.bilingify.readest",
  ]
end
