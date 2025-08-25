cask "mountmate" do
  version "4.2"
  sha256 "debbe07305ed82559d500a06a1b3799260dd7b9016f43ac9e9ada00fd7f66039"

  url "https://github.com/homielab/mountmate/releases/download/v#{version}/MountMate_#{version}.dmg",
      verified: "github.com/homielab/mountmate/"
  name "MountMate"
  desc "Menubar app to easily manage external drives"
  homepage "https://homielab.com/page/mountmate"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "MountMate.app"

  zap trash: "~/Library/Preferences/com.homielab.mountmate.plist"
end
