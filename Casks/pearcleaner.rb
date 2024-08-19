cask "pearcleaner" do
  version "3.8.5"
  sha256 "4b699860a5e8cf2d577ec923b9e025416a8259f407718537aaffd375163df981"

  url "https://github.com/alienator88/Pearcleaner/releases/download/#{version}/Pearcleaner.zip"
  name "Pearcleaner"
  desc "A free, source-available and fair-code licensed mac app cleaner"
  homepage "https://github.com/alienator88/Pearcleaner"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Pearcleaner.app"
  
  uninstall launchctl:  "com.alienator88.PearcleanerSentinel*",
            quit:       "com.alienator88.Pearcleaner",
            login_item: "Pearcleaner"

  zap trash: [
    "~/Library/Caches/com.alienator88.Pearcleaner",
    "~/Library/HTTPStorages/com.alienator88.Pearcleaner",
    "~/Library/Preferences/com.alienator88.Pearcleaner.plist",
    "~/Library/Saved Application State/com.alienator88.Pearcleaner.savedState",
    "~/Library/Containers/com.alienator88.Pearcleaner",
    "~/Library/Group Containers/com.alienator88.Pearcleaner",
    "~/Library/Application Scripts/com.alienator88.Pearcleaner",
  ]
end
