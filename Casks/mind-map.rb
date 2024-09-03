cask "mind-map" do
  arch arm: "arm64", intel: "x64"
  version "0.11.0"
  sha256 arm: "c48068cdeb1d9bbb313f4a4344f09d50ac5ccb5811f4bd19d21e89761cfe309f",
         intel: "c352e30f2910f2c2ee0b132dcc28a97c3169741288b44a6bfa7a48a613e14916"

  url "https://github.com/wanglin2/mind-map/releases/download/electron-#{version}/-mac-#{version}-#{arch}.dmg"
  name "mind-map"
  desc "relatively powerful web mind map"
  homepage "https://github.com/wanglin2/mind-map"

  livecheck do
    url "https://github.com/wanlin2/mind-map/release"
    regex(%r{/electron-(\d+(?:\.\d+)){2,}}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        "#(match[1])"
      end
   end
  end


  app "思绪思维导图.app"

  zap trash: [
    "~/Library/Saved Application State/com.electron.thoughts.savedState",
    "~/Library/Preferences/com.electron.thoughts.plist",
  ]
end
