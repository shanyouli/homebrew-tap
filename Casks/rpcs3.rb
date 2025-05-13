cask "rpcs3" do
  version "0.0.36,17930,b1b02e04,b1b02e042539e86b67daa9a88bd74d6b3682d8e9"
  sha256 "7694d2279c9cf95aad49489ba3b4565f2893d4a1a492781d063b124bf5d65a40"

  url "https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-#{version.csv.fourth}/rpcs3-v#{version.csv.first}-#{version.csv.second}-#{version.csv.third}_macos.7z",
      verified: "github.com/RPCS3/rpcs3-binaries-mac/"
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

  app "RPCS3.app"

  zap trash: ""

  caveats do
    requires_rosetta
  end
end
