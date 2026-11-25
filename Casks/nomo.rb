cask "nomo" do
  version "0.7.5"
  sha256 "42554014ab10b17b982939507125064782de7a82693eabdb61197ee8cf71c72b"

  url "https://github.com/nomo-md/nomo/releases/download/v#{version}/Nomo_#{version}_aarch64.dmg"
  name "Nomo"
  desc "WYSIWYG, real-time rendering, distraction-free Markdown editor"
  homepage "https://nomo-md.github.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Nomo.app"

  zap trash: [
    "~/Library/Application Support/com.nomo.desktop",
    "~/Library/Caches/com.nomo.desktop",
    "~/Library/Logs/com.nomo.desktop",
    "~/Library/Preferences/com.nomo.desktop.plist",
    "~/Library/WebKit/com.nomo.desktop",
  ]
end
