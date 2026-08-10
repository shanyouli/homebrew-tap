cask "readest" do
  version "0.12.1"
  sha256 "178a7e40c2230034913e04a02787335db2d4c5920faee85826180d63f146ce37"

  url "https://github.com/readest/readest/releases/download/v#{version}/Readest_#{version}_universal.dmg"
  name "readest"
  desc "Modern, feature-rich ebook reader"
  homepage "https://github.com/readest/readest"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Readest.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/Application Support/com.bilingify.readest",
    "~/Library/Caches/com.bilingify.readest",
    "~/Library/WebKit/com.bilingify.readest",
  ]
end
