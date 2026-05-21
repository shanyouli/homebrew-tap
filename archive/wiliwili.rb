# Documentation: https://docs.brew.sh/Cask-Cookbook
#                https://docs.brew.sh/Adding-Software-to-Homebrew#cask-stanzas
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
cask "wiliwili" do
  arch arm: "AppleSilicon", intel: "intelChip"

  version "1.5.3"
  sha256 arm:   "67665e626ae3b050169c2fa7dd1c5105c310eeab7819c4415be52c49db1c74f8",
         intel: "07409c601988ba8433ec53f359101057dda3ae6a3acc6f6101aab9f767427474"

  url "https://github.com/xfangfang/wiliwili/releases/download/v#{version}/wiliwili-macOS-#{arch}.dmg",
      verified: "github.com/xfangfang/wiliwili/"
  name "wiliwili"
  desc "第三方B站客户端"
  homepage "https://xfangfang.github.io/wiliwili"

  livecheck do
    url "https://github.com/xfangfang/wiliwili"
    strategy :github_latest
  end

  # depends_on macos: ""

  app "wiliwili.app"

  zap trash: "~/Application Support/wiliwili"
end
