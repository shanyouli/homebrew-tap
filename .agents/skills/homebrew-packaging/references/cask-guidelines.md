# cask 编写准则

以本机 Homebrew 的 DSL 与 RuboCop cops 为准；以下为本仓库实践沉淀。编写前通读本文，
与 SKILL.md 第 3 步（元数据取证、运行时验证）配合使用。

## 基础 stanza

- token 与文件名一致；token 按 Homebrew tokenization（无空格驼峰名全小写：`SpacePreview` → `spacepreview`，同 `QuickRecorder` → `quickrecorder` 先例）。
- 必填：`version`、`sha256`、`url`（可插值）、`name`、`desc`、`homepage`。
- `desc` 小写开头、不以 name 开头、一句话说清功能；`homepage` 带协议与结尾斜杠。
- 双架构用 `arch arm: "arm64", intel: "x64"`，`sha256 arm: ..., intel: ...` 分支，URL 以 `#{arch}` 插值；
  仅当官方同一 release 同时提供两种架构安装包时才写双架构，不推测。

## 架构与系统要求

- macOS 专属应用必须声明 `depends_on :macos`：否则跨平台加载会因 `sha256` 解析为 nil 报 `Invalid cask`。
- 单架构发行明确声明架构依赖（如 `depends_on arch: :arm64`）。
- 最低 macOS 版本来自制品 `LSMinimumSystemVersion` 或上游打包配置（如 `tauri.macos.conf.json` 的
  `minimumSystemVersion`）：本仓库 `Homebrew/OSDependsOn` cop 视 cask 中的最低版本为冗余，
  配方统一只写 `depends_on :macos`（`:catalina` 及更低版本符号已进 `DISABLED_MACOS_VERSIONS`，
  加载即抛异常），版本要求写进交付说明，不写入 cask。

## stanza 顺序

- 以本机 Homebrew 的 `STANZA_GROUPS` 为准（`rubocops/cask/constants/stanza.rb`）：
  `arch`/`version`/`sha256`/`url` 信息组 → `livecheck` → `auto_updates`/`conflicts_with`/`depends_on` →
  artifact 组（`suite`/`app`/`binary`/…）→ `*_steps` → `uninstall` → `zap` → `caveats`。
- **`caveats` 是最后一组、写在 `zap` 之后**，不是 artifact 组之前；错位会被 `Cask/StanzaOrder` 判违规。

## livecheck

- 按真实 tag/发布策略编写，默认只校验声明，不联网执行。
- GitHub Releases 用 `url :url` + `strategy :github_latest`；需要正则时写 `regex`；
  上游 tag 带 `v` 前缀而版本号不带时，确认 strategy 是否自动剥离。

## 弃用 API 与步骤

- 不使用已弃用的 `preflight` / `postflight`，改用 `preflight_steps` / `postflight_steps` /
  `uninstall_preflight_steps` / `uninstall_postflight_steps`。
- 步骤中写文件用 `write_file`（默认 `base: :staged_path`，内容中 `#{appdir}` 改用 `{{appdir}}` 模板变量），不用 `File.write`。

## uninstall 与 zap

- `uninstall` 覆盖实际安装动作（app/pkg/binary/launchctl/quit 等）；pkg 安装还需 `pkgutil`。
- `zap` 只写有证据的路径：inspect 候选只是起点，与运行实况或源码证据冲突时以实际为准
  （流程见 SKILL.md 第 3 步运行时验证）；未产生但有源码证据的项标注触发条件保留。
- 不批量套常见目录模板；不使用宽泛通配符；不删除用户文档、Markdown 笔记或共享数据。
- 单元素数组直接写字符串（`zap trash: "~/Library/…"`），`Cask/ArrayAlphabetization` 会拒绝单元素数组。

## caveats

- 只写用户安装后需要知道且有证据的事项：签名/公证状态与 Gatekeeper 放行方式、
  需要手动授予的权限（辅助功能、自动化）、与系统设置的交互。
- 来源通常是上游 release notes 自述或制品 codesign 检查；无证据不写。

## 排错

- 不盲信 `brew style --fix`：对 `Cask/Desc` 的自动修正会产出不通顺文案，须人工复核修正结果。
- 排查校验失败时按根因归类：一个 stanza 缺陷可能连带多条报错，不要按报错条数判断问题数量。

## 最小配方模板

新 cask 从最小配方模板创建（模板相对本 skill 目录）：复制 `references/cask-template.rb` 到
仓库根 `Casks/<token>.rb`，按证据填充占位符并删除未用注释行，再跑 SKILL.md 第 5 步验证。

模板只含最小可加载结构（必需 stanza + 注释化的可选项）；`arch` 分支、双 `sha256`、多项 `zap`、
末组 `caveats` 等扩展写法，参照填充后的真实成品：仓库根 `Casks/spacepreview.rb`（双架构完整例）、
`Casks/nomo.rb`（单架构例）、`Casks/winc.rb`（单元素 zap 例）。
