cask "piliplus" do
  version "2.0.0,2.0.0,4715"
  sha256 "519a844e889c70d3fe6ecd60531fccfffc2cb6478cff5f258e6c830fe0baf9e3"

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
