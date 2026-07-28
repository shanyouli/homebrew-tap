cask "vicinae" do
  version "0.24.0"
  sha256 "a3ced923ebe07da1373624c734404e983990752ece5f0bfe4dfacc516af8bd98"

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
