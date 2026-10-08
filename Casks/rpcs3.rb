cask "rpcs3" do
  version "0.0.43,20247,222754bf,222754bfd3d2a482ea60b27d5661a12960491fd9"
  sha256 "10bde41d2e1d2c044242d00bd372aee84dfdf708bc08cac525a3fbf489a7af9e"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.fourth}/rpcs3-v#{version.csv.first}-#{version.csv.second}-#{version.csv.third}_macos.7z"
  name "RPCS3"
  desc "PS3 emulator/debugger"
  homepage "https://rpcs3.net/"

  livecheck do
    url "https://github.com/RPCS3/rpcs3-binaries-mac/releases"
    regex(%r{/build-([a-zA-Z0-9]+)/rpcs3-v(\d+(?:\.\d+){2,})-(\d+)-([0-9a-zA-Z]+)_macos.7z}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        "#{match[2]},#{match[3]},#{match[4]},#{match[1]}"
      end
    end
  end

  depends_on macos: :sequoia

  app "RPCS3.app"

  zap trash: ""

  caveats do
    requires_rosetta
  end
end
