cask "piliplus" do
  version "1.1.6,1.1.6,4626"
  sha256 "6226eecbb417e2e2d83d239b2871004e2fc76bbbf94ccf08b8ea587c620cbcb8"

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
