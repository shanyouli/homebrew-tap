# 指令

## 校验约定

- `brew audit` 离线优先：本地校验 cask/formula 时默认不加 `--online`，避免触发资源下载与网络请求以加快校验速度。仅当确需验证下载 URL、在线资源或 livecheck 在线行为时，才显式追加 `--online`。
- 修改或新增 cask/formula 后，提交前先用 `brew audit`（离线）与 `brew style` 自测通过。

## 联网操作约定

- **未经用户当次明确指令，禁止执行任何联网操作**，包括但不限于 `brew livecheck`、`brew audit --online`、`brew reinstall`／`brew install`（会触发下载）、`curl`/`wget` 等。联网操作可能耗时、受网络环境限制或失败，须由用户显式授权后执行。
- 需要联网的校验项，在交付说明中列为「待用户手动执行」，不要自行运行。
- 允许的本地（离线）校验手段：`brew style`、`brew audit`（不加 `--online`）、`brew readall`、`brew ruby -e` 加载与断言检查。

## cask 编写约定

- **macOS 专属 cask 必须声明 `depends_on :macos`**：否则 `brew readall` 会在 Linux 模拟下因 `sha256` 为 nil 报 `Invalid cask (Linux on ARM64/Intel x86_64)`。
- **不要使用已弃用的 macOS 版本符号**：`:catalina` 及更低版本已进入 `DISABLED_MACOS_VERSIONS`（最低支持 Big Sur），加载即抛异常；统一写 `depends_on :macos`。
- **`preflight` / `postflight` 等旧式 stanza 已弃用**，改用 `preflight_steps` / `postflight_steps` / `uninstall_preflight_steps` / `uninstall_postflight_steps`；其中 `File.write` 改用 `write_file`（默认 `base: :staged_path`，内容中 `#{appdir}` 改用 `{{appdir}}` 模板变量）。
- **stanza 顺序以 `STANZA_GROUPS` 为准**（`arch`/`version`/`url` 信息组 → `livecheck` → `auto_updates`/`conflicts_with`/`depends_on` → artifact 组 → `*_steps` → `uninstall` → `zap` → `caveats`），错位会被 `Cask/StanzaOrder` 判违规。
- **不要盲信 `brew style --fix`**：其对 `Cask/Desc` 的自动修正会产出语法不通的文案（如把 `"uPic is a ..."` 改成 `"Is a ..."`），须人工复核或手工修正。
- **一条坏 cask 会放大成十几条报错**：`Readall.valid_tap?` 遍历全部 OS×arch 组合，单个 cask 抛异常会导致 `brew tap` 整体失败；排查时按根因归类，不要按报错条数判断问题数量。
- 提交前用 `brew style` + `brew audit`（离线）自测；`brew livecheck` 属联网操作，按上节约定处理。
