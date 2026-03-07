cask "piliplus" do
  version "2.0.0.1,2.0.0,4721"
  sha256 "2698dd8468c12ca1447aa5fba69375b277262c4e60a37c91f14230b1f0761d4b"

  url "https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/#{version.csv.first}/PiliPlus_macos_#{version.csv.second}+#{version.csv.third}.dmg"
  name "piliplus"
  desc "Bilibili"
  homepage "https://github.com/bggRGjQaUbCoE/PiliPlus"

  livecheck do
   url "https://github.com/bggRGjQaUbCoE/PiliPlus/releases"
   regex(%r{/([0-9.]+)/PiliPlus_macos_([^/]+)%2B(\d+)\.dmg}i)
   strategy :github_latest do |json, regex|
     json["assets"]&.map do |asset|
       match = asset["browser_download_url"]&.match(regex)
       next if match.blank?

       "#{match[1]},#{match[2]},#{match[3]}"
     end
   end
  end

  app "PiliPlus.app"

  zap trash: [
    "~/Library/Application Scripts/com.example.piliplus",
    "~/Library/Containers/com.example.piliplus",
  ]
end
