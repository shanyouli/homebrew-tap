cask "rpcs3" do
  version "0.0.39,18690,4a12f70f,4a12f70f2cd43ab554da60cc58681df86fe06e58"
  sha256 "23067b7722cb95bec21db2b1dbec5e28823318c739e43f52706336b08cec9d3f"

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

  depends_on macos: ">= :sonoma"

  app "RPCS3.app"

  zap trash: ""

  caveats do
    requires_rosetta
  end
end
