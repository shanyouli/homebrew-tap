# 指令

## 校验约定

- **离线校验统一使用 `scripts/validate.rb`，不依赖当前仓库被注册或软链为 tap。** 脚本自动识别 `Casks/` 和 `Formula/` 下的 Ruby 文件，从内容加载并执行严格审计，再批量执行 Homebrew 样式检查。新增配方后无需生成或修改验证命令。
  ```sh
  # 必须指定文件，可混合 cask 与 formula，并支持多个文件
  brew ruby scripts/validate.rb -- Casks/nomo.rb Formula/mole.rb

  # 校验指定目录，递归扫描并自动去重
  brew ruby scripts/validate.rb -- Casks/ Formula/

  # 显式扫描整个仓库的 Casks/ 和 Formula/（不扫描 archive/）
  brew ruby scripts/validate.rb -- --all

  # 查看帮助
  brew ruby scripts/validate.rb -- --help
  ```
- 默认必须指定一个或多个文件/目录，无参数时报错；只有 `--all` 才扫描全仓库，且不能与路径混用。路径参数相对于当前工作目录解析；`--all` 按脚本所在仓库定位，不依赖调用目录。退出码：`0` 全部通过、`1` 审计或样式失败、`2` 参数或环境错误。单个配方失败不会跳过其余文件；脚本不自动修复配方或安装校验依赖，依赖缺失须报告阻塞，不得自行联网安装。
- 脚本使用 Homebrew 内部的内容加载与 auditor API，只运行文件级校验，不设置 tap 身份，不执行安装、下载、签名检查或 `test do`。仅加载可信的本地配方；不是任意 Ruby 代码的安全沙箱。Homebrew 更新导致内部 API 不兼容时，应修复脚本，而不是临时生成独立审计命令。
- tap 级审计和跨 OS × 架构加载检查不在本脚本范围内；确需时，使用已安装的 `brew audit --tap=...` / `brew readall <tap>`，并确认该 tap 指向的是待校验工作树。
- `brew audit` 默认不加 `--online`，也不使用隐含联网的 `--new`；确需在线检查时须先取得用户当次明确授权。
- 修改或新增 cask/formula 后，提交前须用本脚本校验相关文件并通过。

## 联网操作约定

- **未经用户当次明确指令，禁止执行任何联网操作**，包括但不限于 `brew livecheck`、`brew audit --online`、`brew reinstall`／`brew install`（会触发下载）、`curl`/`wget` 等。联网操作可能耗时、受网络环境限制或失败，须由用户显式授权后执行。
- 需要联网的校验项，在交付说明中列为「待用户手动执行」，不要自行运行。
- 允许的本地（离线）校验手段：`brew ruby scripts/validate.rb -- <file ...>` / `--all`、`brew style <file>`、`brew audit`（不加 `--online` / `--new`，仅限 tap 已安装时）、`brew readall`（仅限 tap 已安装时）以及其他 `brew ruby` 加载与断言检查。

## cask 编写约定

- **macOS 专属 cask 必须声明 `depends_on :macos`**：否则 `brew readall` 会在 Linux 模拟下因 `sha256` 为 nil 报 `Invalid cask (Linux on ARM64/Intel x86_64)`。
- **不要使用已弃用的 macOS 版本符号**：`:catalina` 及更低版本已进入 `DISABLED_MACOS_VERSIONS`（最低支持 Big Sur），加载即抛异常；统一写 `depends_on :macos`。
- **`preflight` / `postflight` 等旧式 stanza 已弃用**，改用 `preflight_steps` / `postflight_steps` / `uninstall_preflight_steps` / `uninstall_postflight_steps`；其中 `File.write` 改用 `write_file`（默认 `base: :staged_path`，内容中 `#{appdir}` 改用 `{{appdir}}` 模板变量）。
- **stanza 顺序以 `STANZA_GROUPS` 为准**（`arch`/`version`/`url` 信息组 → `livecheck` → `auto_updates`/`conflicts_with`/`depends_on` → artifact 组 → `*_steps` → `uninstall` → `zap` → `caveats`），错位会被 `Cask/StanzaOrder` 判违规。
- **不要盲信 `brew style --fix`**：其对 `Cask/Desc` 的自动修正会产出语法不通的文案（如把 `"uPic is a ..."` 改成 `"Is a ..."`），须人工复核或手工修正。
- **一条坏 cask 会放大成十几条报错**：`Readall.valid_tap?` 遍历全部 OS×arch 组合，单个 cask 抛异常会导致 `brew tap` 整体失败；排查时按根因归类，不要按报错条数判断问题数量。
- 提交前用 `brew ruby scripts/validate.rb -- <file ...>` 自测；如需整 tap 校验，再额外执行已安装且指向待校验工作树的 `brew audit --tap=...`（不加 `--online` / `--new`）与 `brew readall`。`brew livecheck` 属联网操作，按上节约定处理。
