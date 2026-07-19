cask "ryujinx-canary" do
  version "1.3.338"
  sha256 "8e7435964ab2397c4be2f162cadbf1c5b0594d6daddc78f4e34b76abafc3c2d1"

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
