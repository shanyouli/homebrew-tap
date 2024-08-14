# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "alexandria" do
  version "0.12.0"
  sha256 "9a6405bb7626fa3611bbda4df524a64d0677edefffd4293ce81085ad3543a458"

  url "https://github.com/btpf/Alexandria/releases/download/v0.12/Alexandria_#{version}_x64.dmg"
  name "alexandria"
  desc "Minimalistic cross-platform eBook reader built with Tauri, Epub.js, and Typescript"
  homepage "https://github.com/btpf/Alexandria"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url :url
    strategy :github_latest
  end

  # depends_on macos: ""

  app "Alexandria.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/Application Support/com.btpf.alexandria",
    "~/Library/Preferences/com.btpf.alexandria.plist",
    "~/Library/Saved Application State/com.btpf.alexandria.savedState",
    "~/Library/WebKit/com.btpf.alexandria",
  ]

  caveats do
    requires_rosetta
  end
end
