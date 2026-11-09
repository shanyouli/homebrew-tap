cask "vicinae" do
  version "0.29.2"
  sha256 "7a5f29d159c81cbf49af5400d8f9cbb2e65bb06a72dd0d4e93c848aad3eaa4e0"

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
