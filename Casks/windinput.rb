cask "windinput" do
  version "0.132.0"
  sha256 "a7971c3d4c6bb6d18fd9da5c43cfb324d6c41652b780fb0af40e046dc497ca24"

  url "https://github.com/huanfeng/WindInput/releases/download/v#{version}/WindInput-#{version}-macOS.pkg"
  name "WindInput"
  desc "Chinese input method for macOS"
  homepage "https://windinput.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  pkg "WindInput-#{version}-macOS.pkg"

  uninstall_preflight_steps do
    run "/bin/bash", args: ["-c", "exec \"$HOME/Applications/卸载清风输入法.app/Contents/Resources/do_uninstall.sh\""],
        must_succeed: false
  end

  uninstall pkgutil: "to.feng.windinput.installer",
            trash: "~/Applications/卸载清风输入法.app"

  caveats <<~EOS
    The installer is not notarized. If Gatekeeper blocks it, Control-click the package and choose Open.
    After installation, add WindInput in System Settings > Keyboard > Text Input > Edit.
    macOS 12 or newer is required.
  EOS
end
