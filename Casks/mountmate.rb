cask "mountmate" do
  version "5.7"
  sha256 "fc84c3f3e3780a629b5fed25ab75342fbb87f335c8f21bf4e6b37e76756e7b95"

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
