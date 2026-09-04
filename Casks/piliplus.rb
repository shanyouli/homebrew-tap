cask "piliplus" do
  version "2.1.2.3,2.1.2,5281"
  sha256 "58bca1a6dfb9f492774584a86dfbcd90a40a24c6064c9eb441055e3f71e503d4"

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

  depends_on macos: :monterey

  app "PiliPlus.app"

  zap trash: [
    "~/Library/Application Scripts/com.example.piliplus",
    "~/Library/Containers/com.example.piliplus",
  ]
end
