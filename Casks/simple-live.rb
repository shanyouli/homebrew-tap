cask "simple-live" do
  version "1.8.3,10803"
  sha256 "dedc3cea7548ed97e2f4c8595deacc5183ae8a33c189fb777cc4695665831b10"

  url "https://github.com/xiaoyaocz/dart_simple_live/releases/download/v#{version.csv.first}/simple_live_app-#{version.csv.first}%2B#{version.csv.second}-macos.dmg"
  name "simple-live"
  desc "简简单单的看直播"
  homepage "https://github.com/xiaoyaocz/dart_simple_live"

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

  app "Simple Live.app"

  zap trash: [
    "~/Library/Application Scripts/com.xycz.simpleLiveApp",
    "~/Library/Containers/com.xycz.simpleLiveApp",
  ]
end
