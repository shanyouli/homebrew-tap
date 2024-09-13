cask "ryujinx" do
  version "1.1.1386"
  sha256 "270e51d5fb5106eb606673eba41b81ddc4c4b0dac11c2ac2fe53ed4872c93f8f"

  url "https://github.com/Ryujinx/release-channel-master/releases/download/#{version}/ryujinx-#{version}-macos_universal.app.tar.gz",
      verified: "github.com/Ryujinx/release-channel-master/"
  name "Ryujinx"
  desc "Simple, experimental Nintendo Switch emulator"
  homepage "https://ryujinx.org/"

  livecheck do
    url :url
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
