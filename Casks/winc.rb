cask "winc" do
  arch arm: "arm64", intel: "x64"

  version "0.1.857"
  sha256 arm:   "563cc015948203c702ab24c664dc6788743cacad7555b1af951e81857d80904b",
         intel: "b85c867ba6d612c4a6e81d225e238b023e8d73a9233c3c8eb65a525abe9af196"

  url "https://github.com/DEEIX-AI/Winc/releases/download/v#{version}/Winc-#{version}-macos-#{arch}.dmg"
  name "Winc"
  desc "Native code editor built with Rust"
  homepage "https://winc.si/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "winc.app"

  zap trash: "~/Library/Application Support/winc"
end
