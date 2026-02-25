cask "compresso" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "1d3c700a16963534b9c1b5bfaa08ee2fb5729720dcea2772ba23210d4cbd445e",
         intel: "306dd6dce3b62c4736558acb5c2e4e3b901c6c39f78e7f08080cee8f85f441b1"

  url "https://github.com/codeforreal1/compressO/releases/download/#{version}/CompressO_#{version}_#{arch}.dmg"
  name "compressO"
  desc "Convert any video into a tiny size"
  homepage "https://github.com/codeforreal1/compressO"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "CompressO.app"

  zap trash: [
    "~/Library/Application Support/com.compresso.app",
    "~/Library/Caches/com.compresso.app",
    "~/Library/Preferences/com.compresso.app.plist",
    "~/Library/Saved Application State/com.compresso.app.savedState",
    "~/Library/WebKit/com.compresso.app",
  ]
end
