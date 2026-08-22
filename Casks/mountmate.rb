cask "mountmate" do
  version "5.17"
  sha256 "b358793e297d9ed478d3499938fa8a38482c38e04e0d8c981611e55e902a2f67"

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
