cask "vicinae" do
  version "0.25.0"
  sha256 "35bb1670fb29f1e1f97034ea250f83188bcfa19257e781cf89f016b793805d56"

  url "https://github.com/vicinaehq/vicinae/releases/download/v#{version}/Vicinae.dmg",
      verified: "github.com/vicinaehq/vicinae/"
  name "vicinae"
  desc "Focused launcher for your desktop - native, fast, extensible"
  homepage "https://vicinae.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Vicinae.app"

  zap trash: [
    "~/.cache/vicinae",
    "~/.config/vicinae",
    "~/.local/share/vicinae",
    "~/.local/state/vicinae",
  ]

  caveats do
    "Requires macOS 14.4 or later."
  end
end
