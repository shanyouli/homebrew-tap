cask "winc" do
  arch arm: "arm64", intel: "x64"

  version "0.1.970"
  sha256 arm:   "ac64a138fdc4103b80908c26b74cc0be71dfdccec587d39e74feaa2f2e21fe42",
         intel: "3e1048380c527b4bcad22d9060e27293d43d3f96673b8cbdd4718529fb8ef25c"

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
