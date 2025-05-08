# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "stillcolor" do
  version "1.1"
  sha256 "dfa8c046540764df4bc462479190aafc60ecc6b25d43c54feeab65b2c29ee0f6"

  url "https://github.com/aiaf/Stillcolor/releases/download/v#{version}/Stillcolor-v#{version}.zip"
  name "stillcolor"
  desc "Designed for Apple silicon Macs"
  homepage "https://github.com/aiaf/Stillcolor"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url "https://github.com/aiaf/Stillcolor"
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Stillcolor.app"

  # Documentation: https://docs.brew.sh/Cask-Cookbook#stanza-zap
  zap trash: [
    "~/Library/Application Scripts/com.makkuk.Stillcolor",
    "~/Library/Containers/com.makkuk.Stillcolor",
  ]
end
