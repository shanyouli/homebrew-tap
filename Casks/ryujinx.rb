cask "ryujinx" do
  version "1.1.1403"
  sha256 "07083574edf1a4a19d0ef4c82ef1baa07cca8465395350a750073f083d0c4053"

  url "https://github.com/Julienraptor01/Ryujinx/releases/download/#{version}/ryujinx-#{version}-macos_universal.app.tar.gz",
      verified: "github.com/Julienraptor01/Ryujinx/"
  name "Ryujinx"
  desc "Simple, experimental Nintendo Switch emulator"
  homepage "https://ryujinx.org/"

  livecheck do
    url "https://github.com/Julienraptor01/Ryujinx"
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
