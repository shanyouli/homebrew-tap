cask "ryujinx-canary" do
  version "1.3.333"
  sha256 "f7f4f0d813abbcc3a7b5f880c3c387475ec4aa5239d475f7263b1e121a819d7a"

  url "https://git.ryujinx.app/Ryubing/Canary/releases/download/#{version}/ryujinx-canary-#{version}-macos_universal.app.tar.gz"
  name "Ryujinx"
  desc "Simple, experimental Nintendo Switch emulator"
  homepage "https://ryujinx.app/"

  livecheck do
    url "https://git.ryujinx.app/Ryubing/Canary/releases.atom"
    regex(/Canary v?(\d+(?:\.\d+)+)/i)
  end

  conflicts_with cask: "ryujinx"
  depends_on macos: :monterey

  app "ryujinx.app"

  zap trash: [
    "~/Library/Application Support/CrashReporter/Ryujinx_1EA4C51C-1E99-5395-A3A6-456A7C843B09.plist",
    "~/Library/Logs/Ryujinx",
    "~/Library/Preferences/org.ryujinx.Ryujinx.plist",
    "~/Library/Saved Application State/org.ryujinx.Ryujinx.savedState",
  ]
  # "~/Library/Application Support/Ryujinx",
end
