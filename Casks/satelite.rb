cask "satelite" do
  version "1.0.46"
  sha256 "549fd2673f621d5fcba620ee050693fe0d5268becce6f0a327b712fe1eaccbc6"

  url "https://github.com/zn0wii/satelite-proxy/releases/download/v#{version}/Satelite_#{version}_aarch64.dmg"
  name "Satelite"
  desc "轻量、好看的 sing-box、Xray 与 mihomo 桌面代理客户端"
  homepage "https://github.com/zn0wii/satelite-proxy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "Satelite.app"

  zap trash: [
    "~/Library/Application Support/com.satelite.proxy",
    "~/Library/Caches/com.satelite.proxy",
    "~/Library/LaunchAgents/com.satelite.proxy.plist",
    "~/Library/Saved Application State/com.satelite.proxy.savedState",
    "~/Library/WebKit/com.satelite.proxy",
  ]

  caveats <<~EOS
    Satelite 未使用 Apple Developer 证书签名，首次启动可能被 Gatekeeper 拦截。
    如提示“应用已损坏”，可执行：
      xattr -dr com.apple.quarantine "/Applications/Satelite.app"
  EOS
end
