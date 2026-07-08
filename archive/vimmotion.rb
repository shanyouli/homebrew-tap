cask "vimmotion" do
  version "1.2.3"
  sha256 "c14bb9355b5191d15a5c7224c48763bf167ca926af39206d308b1cf9aca00c00"

  url "https://github.com/dwarvesf/VimMotionApp/releases/download/v#{version}/VimMotion.#{version}.dmg"
  name "VimMotion"
  homepage "https://github.com/dwarvesf/VimMotionApp/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "VimMotion.app"
end
