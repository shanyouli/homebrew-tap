cask "mountmate" do
  version "5.5"
  sha256 "4c3b0e5ae32e06799eea4b63ec3f17d94b905910e2f215c930af55985ef0ca60"

  url "https://github.com/homielab/mountmate/releases/download/v#{version}/MountMate_#{version}.dmg"
  name "MountMate"
  desc "Menubar app to easily manage external drives"
  homepage "https://github.com/homielab/mountmate"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "MountMate.app"

  zap trash: "~/Library/Preferences/com.homielab.mountmate.plist"
end
