cask "piliplus" do
  version "2.1.0,2.1.0,5109"
  sha256 "a5b8c44f1b601ebab54558a72b042dd23b47d0af5994270b11d96d1373f01b79"

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

  depends_on :macos

  app "PiliPlus.app"

  zap trash: [
    "~/Library/Application Scripts/com.example.piliplus",
    "~/Library/Containers/com.example.piliplus",
  ]
end
