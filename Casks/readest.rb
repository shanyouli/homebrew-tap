cask "readest" do
  version "0.9.15"
  sha256 "39d6b2086be3c40349547a2958a2f728ec36124735efc07b4b4863cb1fc66707"

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
