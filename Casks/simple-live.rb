# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "simple-live" do
  version "1.6.5,10605"
  sha256 "e2ca9b58ca58a4690bc3afb0710fbe33f20fef68d8ef1af97f521ae6928c3636"

  url "https://github.com/xiaoyaocz/dart_simple_live/releases/download/v#{version.csv.first}/simple_live_app-#{version.csv.first}%2B#{version.csv.second}-macos.dmg"
  name "simple-live"
  desc "简简单单的看直播"
  homepage "https://github.com/xiaoyaocz/dart_simple_live"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url "https://github.com/xiaoyaocz/dart_simple_live/releases"
    regex(%r{/v(\d+(\.\d+){2})/simple_live_app-(?:\d+(?:\.\d+){2})%2B(\d{5,})-macos.dmg}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[3]}"
      end
    end
  end

  # depends_on macos: ""

  app "Simple Live.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/Application Scripts/com.xycz.simpleLiveApp",
    "~/Library/Containers/com.xycz.simpleLiveApp",
  ]
end
