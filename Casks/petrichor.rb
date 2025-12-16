cask "petrichor" do
  version "1.3.0"
  sha256 "302fb5e65d64817f0c8364f490c2f3bd81646757d57a4cdbc0859c315143d57f"

  url "https://github.com/kushalpandya/Petrichor/releases/download/v#{version}/Petrichor-#{version}-Universal.dmg"
  name "Petrichor"
  desc "Native music player with folder-based library management"
  homepage "https://github.com/kushalpandya/Petrichor"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)+(?:-(alpha|beta)-\d+)?)$/i)
  end

  depends_on macos: ">= :sonoma"

  app "Petrichor.app"

  zap trash: [
    "~/Library/Application Support/org.Petrichor",
    "~/Library/Caches/org.Petrichor",
    "~/Library/Preferences/org.Petrichor.plist",
    "~/Library/Saved Application State/org.Petrichor.savedState",
  ]

  caveats <<~EOS
    Petrichor is currently in alpha. Expect bugs and breaking changes.

    #{token} is not signed with an Apple Developer certificate.

    To open for the first time:
    1. Right-click the app and select "Open"
    2. Click "Open" in the dialog

    If you see "Petrichor cannot be opened" error:
      xattr -dr com.apple.quarantine /Applications/Petrichor.app
  EOS
end
