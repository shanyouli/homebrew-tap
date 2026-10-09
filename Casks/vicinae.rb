cask "vicinae" do
  version "0.29.1"
  sha256 "e83cef0f9ad5cff3172d4520054528e4f41de7d92cd0a4c0a7890ece4efd6e1f"

  url "https://github.com/vicinaehq/vicinae/releases/download/v#{version}/Vicinae.dmg"
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
