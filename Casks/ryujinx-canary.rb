cask "ryujinx-canary" do
  version "1.3.224"
  sha256 "fcb2771e10ceb1715d7cc560f5e9e9e66735d7aee9f8f60bb3fa24cbad775dd7"

  url "https://git.ryujinx.app/api/v4/projects/68/packages/generic/Ryubing-Canary/#{version}/ryujinx-canary-#{version}-macos_universal.app.tar.gz"
  name "Ryujinx"
  desc "Simple, experimental Nintendo Switch emulator"
  homepage "https://ryujinx.app/"

  livecheck do
    url "https://git.ryujinx.app/ryubing/ryujinx.git"
  end

  conflicts_with cask: "ryujinx"
  depends_on macos: ">= :monterey"

  app "ryujinx.app"

  zap trash: [
    "~/Library/Application Support/CrashReporter/Ryujinx_1EA4C51C-1E99-5395-A3A6-456A7C843B09.plist",
    "~/Library/Logs/Ryujinx",
    "~/Library/Preferences/org.ryujinx.Ryujinx.plist",
    "~/Library/Saved Application State/org.ryujinx.Ryujinx.savedState",
  ]
  # "~/Library/Application Support/Ryujinx",
end
