cask "winc" do
  arch arm: "arm64", intel: "x64"

  version "0.1.789"
  sha256 arm:   "b00b711aca38574539fc7ce5dece1ac44bdb1b4d60c196c23beaabee04f2df48",
         intel: "4b7e0d8a28a5e1e639a03336d84acf099e69815ef28f5d9d2754a50332a1bb16"

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
