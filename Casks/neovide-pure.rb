cask "neovide-pure" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.17.0"
  sha256 arm:   "ce0f05b6b68dd1c637edbd62e809d1fd3f286ebd5395069836da3beff192a934",
         intel: "7795ff50fc55d4ddf5b1571960c2a5b274f345bc77806ec841ba5589c2e32ee4"

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
