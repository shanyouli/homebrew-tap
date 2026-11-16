cask "winc" do
  arch arm: "arm64", intel: "x64"

  version "0.1.733"
  sha256 arm:   "38a7b7d799526a3c5827041e9535d056685676f244441dd2c987e0b17aa92244",
         intel: "524adf4b0542012bc0f492bac9fd3062dfbba8c27a1dec16e3601d0c05df70ce"

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
