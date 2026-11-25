cask "mind-map" do
  arch arm: "arm64", intel: "x64"

  version "0.21.0"
  sha256 arm:   "544b4f65fac0ea8018a262696d373e67550d054c6f884fe0e49af7457bc97978",
         intel: "077f68767fbc0bc4f2fee2ace32f5136b87e7e56d3c297f03c0c78f0d8c5edff"

  url "https://github.com/wanglin2/mind-map/releases/download/#{version}/-mac-#{version}-#{arch}.dmg"
  name "mind-map"
  desc "Relatively powerful web mind map"
  homepage "https://github.com/wanglin2/mind-map"

  livecheck do
    url "https://github.com/wanglin2/mind-map/releases/latest"
    strategy :page_match
    regex(%r{href=.*?/tag/(\d+(?:\.\d+)+)["' >]}i)
  end

  depends_on :macos

  app "思绪思维导图.app"

  zap trash: [
    "~/Library/Preferences/com.electron.thoughts.plist",
    "~/Library/Saved Application State/com.electron.thoughts.savedState",
  ]
end
