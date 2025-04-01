cask "ryujinx" do
  version "1.2.86"
  sha256 "49fcd62a6a5b484a5b4bf7f3615a12fb8c4535bf8bbe4e9424159ce69183d515"

  url "https://github.com/Ryubing/Stable-Releases/releases/download/#{version}/ryujinx-#{version}-macos_universal.app.tar.gz",
      verified: "github.com/Ryubing/Stable-Releases/"
  name "Ryujinx"
  desc "Simple, experimental Nintendo Switch emulator"
  homepage "https://ryujinx.app/"

  livecheck do
    url "https://github.com/Ryubing/Stable-Releases"
    strategy :github_latest
  end

  app "ryujinx.app"

  zap trash: [
    "~/Library/Application Support/CrashReporter/Ryujinx_1EA4C51C-1E99-5395-A3A6-456A7C843B09.plist",
    "~/Library/Logs/Ryujinx",
    "~/Library/Preferences/org.ryujinx.Ryujinx.plist",
    "~/Library/Saved Application State/org.ryujinx.Ryujinx.savedState",
  ]
  # "~/Library/Application Support/Ryujinx",
end
