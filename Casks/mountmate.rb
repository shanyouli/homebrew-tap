cask "mountmate" do
  version "5.1"
  sha256 "4b075dc453cd55bdc5ded392b8c102dba3eef16a39004121e47afaae141f44f6"

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
