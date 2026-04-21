#!/usr/bin/env ruby
cask "lite-edit" do
  version "1.1.6"
  sha256 "3cc66dafd40b11e1feafb92377851bcfeafbcc2b240b93a25313321586f2caa6"

  url "https://github.com/arietan/lite-edit/releases/download/v#{version}/LiteEdit.dmg"
  name "LiteEdit"
  desc "Lightweight, fast code editor"
  homepage "https://github.com/arietan/lite-edit"

  depends_on macos: ">= :ventura"

  app "LiteEdit.app"

  livecheck do
    url :url
    strategy :github_latest
  end
  postflight do
    system_command "/usr/bin/xattr",
      args: ["-rd", "com.apple.quarantine", "#{appdir}/LiteEdit.app"]
  end

  caveats <<~EOS
    #{token} is not yet code-signed with an Apple Developer ID.
    The quarantine flag is removed automatically during install.
    If macOS still says the app is damaged, run manually:
      xattr -rd com.apple.quarantine #{appdir}/LiteEdit.app
  EOS

  zap trash: [
    "~/Library/Application Support/CrashReporter/LiteEdit_*.plist",
    "~/Library/Preferences/com.liteedit.app.plist",
  ]
end
