cask "lyricsx" do
  version "1.7.3,2551"
  sha256 "ff25c12e8d920ff8d4c4a075d1d312a9a59bd44a76af815437d67d0052462bda"

  url "https://github.com/MxIris-LyricsX-Project/LyricsX/releases/download/v#{version.csv.first}/LyricsX_#{version.csv.first}%2B#{version.csv.second}.zip"
  name "LyricsX"
  desc "Ultimate Lyrics App"
  homepage "https://github.com/MxIris-LyricsX-Project/LyricsX"

  livecheck do
    url "https://github.com/MxIris-LyricsX-Project/LyricsX/releases"
    regex(%r{/v(\d+(\.\d+){2})/LyricsX_(\d+(\.\d+){2})%2B(\d{4})\.zip}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[5]}"
      end
    end
  end

  conflicts_with cask: "lyricsx"

  app "LyricsX.app"

  zap trash: [
    "~/Library/Application Scripts/com.JH.LyricsX",
    "~/Library/Application Scripts/com.JH.LyricsXHelper",
    "~/Library/Application Scripts/D5Q73692VW.group.com.JH.LyricsX",
    "~/Library/Containers/com.JH.LyricsX",
    "~/Library/Containers/com.JH.LyricsXHelper",
    "~/Library/Group Containers/D5Q73692VW.group.com.JH.LyricsX",
  ]
end
