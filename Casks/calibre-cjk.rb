cask "calibre-cjk" do
  # on_ventura :or_newer do
  #   version "7.16.0"
  #   sha256 "1bce729bc1981fcca5a31fd595e248b10e4a405d0edeba5f7c3dd4d4724e1867"

  #   livecheck do
  #     url "https://calibre-ebook.com/dist/osx"
  #     strategy :header_match
  #   end
  # end
  version "7.16.0"
  sha256 "1bce729bc1981fcca5a31fd595e248b10e4a405d0edeba5f7c3dd4d4724e1867"
  url "https://download.calibre-ebook.com/#{version}/calibre-#{version}.dmg"
  name "calibre"
  desc "E-books management software"
  homepage "https://calibre-ebook.com/"

  depends_on macos: ">= :ventura"
  livecheck do
    url "https://github.com/Cirn09/calibre-do-not-translate-my-path"
    strategy :github_latest
  end
  
  conflicts_with cask: "calibre"
  # 缓存目录，通常在用户的 Homebrew 缓存目录中
  patch_cache_dir = "#{HOMEBREW_CACHE}/cask/patches"
  patch_url = "https://github.com/Cirn09/calibre-do-not-translate-my-path/releases/download/v#{version}/mac-patch-backend+update-v#{version}.zip"
  # patch_hash = "f39eccd86b11fb0cbfb93a6dbc621a5d386b7482de6c86dacc240f7ab45b3c9f";
  patch_file = "#{patch_cache_dir}/mac-patch-backend+update-v#{version}.zip"

  # Add this section for your ZIP patch
  preflight do
    # 如果缓存目录不存在，则创建
    FileUtils.mkdir_p patch_cache_dir
    target_path = "#{staged_path}/calibre.app/Contents/Frameworks/plugins"

    # 检查补丁文件是否已经存在于缓存中
    puts "Downloading patch to #{patch_file}"
    unless File.exist?(patch_file)
      # 如果不存在，则下载补丁文件到缓存目录
      system_command "/usr/bin/curl", args: ["-L", "-o", patch_file, patch_url]
    end
      # 计算补丁文件的 SHA256
    # actual_sha256 = Digest::SHA256.file(patch_file).hexdigest

    # 验证哈希值
    # if patch_hash != actual_sha256
    #   raise <<-ERROR_MESSAGE
    #   Downloaded patch file is corrupted or has been tampered with
    #     patch_file hash is:\t#{actual_sha256}
    #     expected hash is:\t#{patch_hash}
    #   ERROR_MESSAGE
    # end
    # Output debug information
    puts "Unzipping patch to #{target_path}"
    # Unzip the patch into the appropriate directory within the calibre app
    system_command '/usr/bin/unzip', args: ['-q', '-o', patch_file, '-d', target_path]
    python_frozen = "#{target_path}/python-lib.bypy.frozen"
    if File.exist?(python_frozen)
      # 添加可执行权限
      system_command "/bin/chmod", args: ["+x", python_frozen]
    end
  end

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
