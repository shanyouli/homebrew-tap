cask "rpcs3" do
  version "0.0.43,20413,085ac6af,085ac6af8a4857b884f4e39b8cca9016a91736ac"
  sha256 "b2f94f64b37e20781d2be3faa79f919b2fa2b498f56c0e9edd13e913b45e27dd"

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
