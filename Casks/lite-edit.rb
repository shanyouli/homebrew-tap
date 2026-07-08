cask "lite-edit" do
  version "1.1.6"
  sha256 "3cc66dafd40b11e1feafb92377851bcfeafbcc2b240b93a25313321586f2caa6"

  url "https://github.com/arietan/lite-edit/releases/download/v#{version}/LiteEdit.dmg"
  name "liteedit"
  desc "Lightweight, fast code editor"
  homepage "https://github.com/arietan/lite-edit"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "LiteEdit.app"

  zap trash: "~/Library/Preferences/com.liteedit.app.plist"
end
