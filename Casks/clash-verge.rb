# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "clash-verge" do
  arch arm: "aarch64", intel: "x64"

  version "1.7.5"
  sha256 arm:   "233082a48421d5ec38cf526c08ef8d276470b9affd43f6ccc3bba50c6f3d7211",
         intel: "d58fac89b42731e73c95d67c36c3e0e2eb4599edc3ac8f62cf8c5d68df68ff33"

  url "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v#{version}/Clash.Verge_#{version}_#{arch}.dmg"
  name "clash-verge"
  desc "Clash Meta GUI based on Tauri"
  homepage "https://github.com/clash-verge-rev/clash-verge-rev"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url :url
    strategy :github_latest
  end

  # depends_on macos: ""

  app "Clash Verge.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/WebKit/top.gydi.clashverge",
    "~/Library/Saved Application State/top.gydi.clashverge.savedState",
    "~/Library/Preferences/top.gydi.clashverge.plist"
  ]
end
