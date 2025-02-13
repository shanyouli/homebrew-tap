cask "calibre-cjk" do
  version "7.24.0"
  sha256 "af6bbd8f0a153f8759ff3bfc6b6e26599d4237ad8736dbb854748061ae636c41"

  url "https://download.calibre-ebook.com/#{version}/calibre-#{version}.dmg"
  name "calibre"
  desc "E-books management software"
  homepage "https://calibre-ebook.com/"

  livecheck do
    url "https://github.com/Cirn09/calibre-do-not-translate-my-path"
    strategy :github_latest
  end

  conflicts_with cask: "calibre"
  depends_on macos: ">= :ventura"

  patch_cache_dir = "#{HOMEBREW_CACHE}/cask/patches"
  patch_url = "https://github.com/Cirn09/calibre-do-not-translate-my-path/releases/download/v#{version}/mac-patch-backend+update-v#{version}.zip"
  patch_file = "#{patch_cache_dir}/mac-patch-backend+update-v#{version}.zip"

  app "calibre.app"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre-complete"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre-customize"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre-debug"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre-parallel"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre-server"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibre-smtp"
  binary "#{appdir}/calibre.app/Contents/MacOS/calibredb"
  binary "#{appdir}/calibre.app/Contents/MacOS/ebook-convert"
  binary "#{appdir}/calibre.app/Contents/MacOS/ebook-device"
  binary "#{appdir}/calibre.app/Contents/MacOS/ebook-edit"
  binary "#{appdir}/calibre.app/Contents/MacOS/ebook-meta"
  binary "#{appdir}/calibre.app/Contents/MacOS/ebook-polish"
  binary "#{appdir}/calibre.app/Contents/MacOS/ebook-viewer"
  binary "#{appdir}/calibre.app/Contents/MacOS/fetch-ebook-metadata"
  binary "#{appdir}/calibre.app/Contents/MacOS/lrf2lrs"
  binary "#{appdir}/calibre.app/Contents/MacOS/lrfviewer"
  binary "#{appdir}/calibre.app/Contents/MacOS/lrs2lrf"
  binary "#{appdir}/calibre.app/Contents/MacOS/markdown-calibre"
  binary "#{appdir}/calibre.app/Contents/MacOS/web2disk"

  preflight do
    FileUtils.mkdir_p patch_cache_dir
    target_path = "#{staged_path}/calibre.app/Contents/Frameworks/plugins"

    puts "Downloading patch to #{patch_file}"
    system_command "/usr/bin/curl", args: ["-L", "-o", patch_file, patch_url] unless File.exist?(patch_file)
    puts "Unzipping patch to #{target_path}"
    system_command "/usr/bin/unzip", args: ["-q", "-o", patch_file, "-d", target_path]
    python_frozen = "#{target_path}/python-lib.bypy.frozen"
    system_command "/bin/chmod", args: ["+x", python_frozen] if File.exist?(python_frozen)
  end

  zap trash: [
    "~/Library/Application Support/calibre-ebook.com",
    "~/Library/Caches/calibre",
    "~/Library/Preferences/calibre",
    "~/Library/Preferences/com.calibre-ebook.ebook-viewer.plist",
    "~/Library/Preferences/net.kovidgoyal.calibre.plist",
    "~/Library/Saved Application State/com.calibre-ebook.ebook-viewer.savedState",
    "~/Library/Saved Application State/net.kovidgoyal.calibre.savedState",
  ]
end
