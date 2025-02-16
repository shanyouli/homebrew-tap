cask "readest" do
  version "0.9.11"
  sha256 "d46fa7244325dfca2f236c571fa08e4b2a59e35fd1c96f575d8b7bbec6a5fa4a"

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
