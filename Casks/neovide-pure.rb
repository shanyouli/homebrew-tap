cask "neovide-pure" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.17.1"
  sha256 arm:   "4ca5df25a4e3d2a5fff63a4b7625c97bc9fd98c4ed359b22c0003c73eddc1c82",
         intel: "1a2f3d2d4dd46f9717cccc3d58f375324fda29953bc86bfa1d8b6766ac535eb6"

  url "https://github.com/neovide/neovide/releases/download/#{version}/Neovide-#{arch}-apple-darwin.dmg"
  name "Neovide"
  desc "Neovim Client"
  homepage "https://github.com/neovide/neovide"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "neovide"
  depends_on :macos

  app "Neovide.app"
  binary "#{appdir}/Neovide.app/Contents/MacOS/neovide"

  zap trash: "~/Library/Saved Application State/com.neovide.neovide"
end
