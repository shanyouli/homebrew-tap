cask "readest" do
  version "0.9.33"
  sha256 "0dc45e8ccc9ac1ac1dd310b78e360cadc1d873ec66289c62fcc8f2f969e67f2b"

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
