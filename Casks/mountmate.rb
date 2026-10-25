cask "mountmate" do
  version "6.3"
  sha256 "8aac53d570af2606f509039e0e65b9850479ad9d97d0a9b1e8a75d393e9f6e18"

  url "https://github.com/homielab/mountmate/releases/download/v#{version}/MountMate_#{version}.dmg"
  name "MountMate"
  desc "Menubar app to easily manage external drives"
  homepage "https://github.com/homielab/mountmate"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "MountMate.app"

  zap trash: "~/Library/Preferences/com.homielab.mountmate.plist"
end
