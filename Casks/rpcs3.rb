cask "rpcs3" do
  version "0.0.37,18004,2b716120,2b7161208ec4c923b8d1f2d37ce8665bb7414053"
  sha256 "f64b6590b4d4b5d874e676f8feea33e1e4840f58b9f1178f738cf925d4635a33"

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
