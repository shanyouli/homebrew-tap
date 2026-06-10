cask "rpcs3" do
  version "0.0.41,19453,f32ff351,f32ff351da5962588c1b4a26c3ec8ade5fd4010e"
  sha256 "2011c290fea2fc0dc9a95e54710bbf54ad11eea66e86009a5f6c0ed4e1f34a98"

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

  depends_on macos: :sonoma

  app "RPCS3.app"

  zap trash: ""

  caveats do
    requires_rosetta
  end
end
