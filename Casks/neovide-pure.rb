cask "neovide-pure" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.17.2"
  sha256 arm:   "45f6bbec3f067ae595578127249714411dc2a8fb37a34f598eb8175ac767ea7b",
         intel: "3f81dce5f8507fa6602c5d194b79d28bc7d9c0bccb5b0380c5648bda25f22a76"

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
