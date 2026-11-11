cask "winc" do
  arch arm: "arm64", intel: "x64"

  version "0.1.626"
  sha256 arm:   "327e673dde2b3a72c9b68a30d7a839421d51e9cf72238edc813cdc76f28a6142",
         intel: "48563c09fb7dccdb093f635770fc272139d5f931b785c6b0f6375ab8923d6e95"

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
