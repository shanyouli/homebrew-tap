# frozen_string_literal: true

cask "upic" do
  version "0.21.1"
  sha256 "1152e2f3995cc33d16d764348618a70a9fb067f2b17f548a813646809aa1154c"

  url "https://github.com/gee1k/uPic/releases/download/v#{version}/uPic.zip"
  # appcast "https://github.com/gee1k/uPic/releases.atom"
  name "uPic"
  desc "Native, powerful, beautiful and simple picture and file upload tool"
  homepage "https://github.com/gee1k/uPic"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on :macos

  app "uPic.app"
  binary "#{staged_path}/upic.wrapper.sh", target: "upic"

  preflight_steps do
    write_file "upic.wrapper.sh", <<~EOS
      #!/bin/bash
      '{{appdir}}/uPic.app/Contents/MacOS/uPic' "$@"
    EOS
  end

  zap trash: [
    "~/Library/Application Scripts/com.svend.uPic.macos",
    "~/Library/Application Scripts/com.svend.uPic.macos.uPicActionExtension",
    "~/Library/Application Scripts/com.svend.uPic.macos.uPicAppIntentsExtension",
    "~/Library/Application Scripts/com.svend.uPic.macos.uPicShareExtension",
    "~/Library/Application Scripts/group.svend.uPic",
    "~/Library/Caches/com.svend.uPic",
    "~/Library/Containers/com.svend.uPic.macos",
    "~/Library/Containers/com.svend.uPic.macos.uPicActionExtension",
    "~/Library/Containers/com.svend.uPic.macos.uPicAppIntentsExtension",
    "~/Library/Containers/com.svend.uPic.macos.uPicShareExtension",
    "~/Library/Group Containers/group.svend.uPic",
    "~/Library/Preferences/com.svend.uPic.plist",
  ]
end
