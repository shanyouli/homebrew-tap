# Shanyouli Tap

## How do I install these formulae?

`brew install shanyouli/tap/<formula>`

Or `brew tap shanyouli/tap` and then `brew install <formula>`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "shanyouli/tap"
brew "<formula>"
```

### yabai 安装建议

>>> 如果你不想从最新的 commit 构建 yabai，建议直接使用官方仓库的 yabai

- 第一次安装
``` bash
brew install shanyouli/tap/yabai --HEAD
codesign -fs 'yabai-cert' $(brew --prefix yabai)/bin/yabai
```

- 后续更新

``` sh
# set codesigning certificate name here (default: yabai-cert)
export YABAI_CERT=

# stop yabai
# yabai --stop-service

# reinstall yabai (remove old service file because homebrew changes binary path)
# yabai --uninstall-service
brew reinstall shanyouli/tap/yabai
codesign -fs "${YABAI_CERT:-yabai-cert}" "$(brew --prefix yabai)/bin/yabai"

```

sudo 授权
``` sh
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
```

## Formula

+ [Mole](https://github.com/tw93/Mole): 命令行清理工具，可以用来取代 Tencent Lemon
+ [yabai](https://github.com/asmvik/yabai) 平铺窗口管理工具,主要是为了获取最新git 版本

## Casks

+ [AirBattery](https://github.com/lihaoyun6/AirBattery): 在Mac上获取你所有设备的电量信息并显示在Dock / 状态栏 / 小组件上! 
+ [Alexandria](https://github.com/btpf/Alexandria): ebook reader tools
+ [apprhyme](https://github.com/canxin121/app_rhyme) 音乐播放器支持 酷狗，网易云音源
+ [aural](https://github.com/kartik-venugopal/aural-player): 音乐播放器
+ [chatgpt](https://github.com/lencx/ChatGPT) lencx chatgpt 客户端
+ [chatmlx](https://github.com/johnmai-dev/ChatMLX) MLX 语言模型，来自 hugging face
+ [Clash.Verge](https://github.com/clash-verge-rev/clash-verge-rev): clash 客户端
+ [compressO](https://github.com/codeforreal1/compressO) 视频压缩工具
+ [cozy-reader](https://github.com/srsng/cozy-reader) epub reader, 目前版本0.1.19 无法工作
+ [DashPlayer](https://github.com/solidSpoon/DashPlayer): 看视频学习双语
+ [emacs](https://github.com/jimeh/emacs-builds): 来自 jimeh 的构建良好的 emacs
+ [FlClash](https://github.com/chen08209/FlClash): 另一个 clash 客户端
+ [GUI.for.Clash](https://github.com/GUI-for-Cores/GUI.for.Clash) clash 客户端
+ [GUI.for.SingBox](https://github.com/GUI-for-Cores/GUI.for.SingBox) singBox 客户端
+ [launchpader](https://github.com/Molay/LaunchPadder) launchpad 排序工具。
+ [LyricsX](https://github.com/MxIris-LyricsX-Project/LyricsX): 歌词显示工具
+ [mind-map](https://github.com/wanglin2/mind-map) 思维导图
+ [mountmate](https://homielab.com/page/mountmate) 外接硬盘管理挂载管理工具
+ [museeks](https://museeks.io/) music 播放器
+ [neovide](https://github.com/neovide/neovide): neovim 的 GUI 工具，将 nvim 和 neovide 分离
+ [nuclear-music-player](https://nuclearplayer.com/): 开源流媒体音乐播放器
+ [petrichor](https://github.com/kushalpandya/Petrichor) 本地音乐播放器
+ [piliplus](https://github.com/bggRGjQaUbCoE/PiliPlus) 第三方 bilibili
+ [Quickrecorder](https://github.com/lihaoyun6/QuickRecorder) QuickRecorder 录屏工具
+ [readest](https://github.com/readest/readest) Readest is a modern, feature-rich ebook reader
+ [RPCS3](https://rpcs3.net/) ps3 模拟器
+ [Ryujinx](https://ryujinx.org/): switch 模拟器
+ [snapbox](https://snapbox.app/): 依赖 ollama.app 的 ai 本地客户端， 可以使用 api
+ [spotube](https://github.com/KRTirtho/spotube): 使用 youtube 作为后端源的音乐播放器
+ [stillcolor](https://github.com/aiaf/Stillcolor) 外置显示屏闪烁，修复工具
+ [tmexclude](https://github.com/PhotonQuantum/tmexclude): macos 官方备份工具过滤设置
+ [uPic](https://github.com/gee1k/uPic): 图床管理工具，最新版需要自己编译
+ [VimMotion](https://github.com/dwarvesf/VimMotionApp): Access macOS UI elements with your fingers stay on keyboard. Inspired by vim-easymotion & avy-mode. 
+ [warden](https://github.com/SidhuK/WardenApp)
+ [wiliwili](https://github.com/xfangfang/wiliwili): bilibil 第三方工具
+ [Zyplayer](https://github.com/Hiram-Wong/ZyPlayer): 跨平台桌面端视频资源播放器,免费高颜值. 

## 部分安装脚本来源

Thanks.

+ [KRTirtho/homebrew-apps: Tap for hosting my app's Casks and formulas](https://github.com/KRTirtho/homebrew-apps/tree/main)
+ [lihaoyun6/homebrew-tap](https://github.com/lihaoyun6/homebrew-tap/tree/master)
+ [dwarvesf--homebrew-tap](https://github.com/dwarvesf/homebrew-tap)

## archive
+ [Calibre](https://calibre-ebook.com/dist/osx): 电子书阅读管理工具
+ [cherry-studio](https://github.com/kangfenmao/cherry-studio) AI chat 客户端
+ [NextChat](https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web): A cross-platform ChatGPT/Gemini UI 
  - 它自2.16.0 版本后没有提供对应的 app 下载包
+ [SimpleLive](https://github.com/xiaoyaocz/dart_simple_live): 简简单单的看直播
  - 对应的安装包需要自己编译
