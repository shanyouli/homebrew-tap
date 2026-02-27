cask "warden" do
  version "0.9.6"
  sha256 "e466e8300093dca7c990d3c8e6a7af9d159955019585334b0151bbda8cbabc30"

  url "https://github.com/SidhuK/WardenApp/releases/download/v#{version}/Warden.zip"
  name "Warden"
  desc "Native AI chat client supporting 10+ providers"
  homepage "https://github.com/SidhuK/WardenApp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "Warden.app"

  zap trash: [
    "~/Library/Application Support/Warden",
    "~/Library/Caches/com.SidhuK.Warden",
    "~/Library/Preferences/com.SidhuK.Warden.plist",
    "~/Library/Saved Application State/com.SidhuK.Warden.savedState",
  ]
end
