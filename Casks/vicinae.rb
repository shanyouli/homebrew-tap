cask "vicinae" do
  version "0.27.3"
  sha256 "084ff94cdf8ccdaeaa7c4d80374ed26047a8c377d053bcf2980a99c9fbbb2452"

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
