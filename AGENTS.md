# 指令

## Homebrew skill

- 创建、新增或更新配方时，读取 `.agents/skills/homebrew-packaging/SKILL.md`；配方编写规范（架构依赖、stanza 顺序、弃用 API、zap 证据）以 skill 为准。必要联网仍须遵守本文件的当次授权约定。
- 验证脚本与测试统一放在该 skill 的 `scripts/` 和 `tests/` 中，不维护第二套验证实现。
- 制品检查脚本 `scripts/inspect.rb`（下载到缓存、只读检查，不安装）属联网操作，按本文件联网约定取得当次授权后使用；`--file` 模式可离线检查已缓存的安装包。

## 校验约定

- **离线校验统一使用 `.agents/skills/homebrew-packaging/scripts/validate.rb`，不依赖当前仓库被注册或软链为 tap。** 脚本自动识别 `Casks/` 和 `Formula/` 下的 Ruby 文件，从内容加载并执行严格审计，再批量执行 Homebrew 样式检查。新增配方后无需生成或修改验证命令。
  ```sh
  # 必须指定文件，可混合 cask 与 formula，并支持多个文件
  brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- Casks/nomo.rb Formula/mole.rb

  # 校验指定目录，递归扫描并自动去重
  brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- Casks/ Formula/

  # 显式扫描整个仓库的 Casks/ 和 Formula/（不扫描 archive/）
  brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- --all

  # 查看帮助
  brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- --help

  # 修改或迁移验证脚本后执行回归测试
  brew ruby .agents/skills/homebrew-packaging/tests/validate_test.rb
  brew ruby .agents/skills/homebrew-packaging/tests/inspect_test.rb
  ```
- 默认必须指定一个或多个文件/目录，无参数时报错；只有 `--all` 才扫描全仓库，且不能与路径混用。路径参数相对于当前工作目录解析；`--all` 从脚本目录向上定位所属 Git 仓库，不依赖调用目录，无法定位时须显式指定路径。退出码：`0` 全部通过、`1` 审计或样式失败、`2` 参数或环境错误。单个配方失败不会跳过其余文件；脚本不自动修复配方或安装校验依赖，依赖缺失须报告阻塞，不得自行联网安装。
- 修改或新增 cask/formula 后，提交前须用本脚本校验相关文件并通过。

## 联网操作约定

- **未经用户当次明确指令，禁止执行任何联网操作**，包括但不限于 `brew livecheck`、`brew audit --online`、`brew reinstall`／`brew install`（会触发下载）、`curl`/`wget` 等。联网操作可能耗时、受网络环境限制或失败，须由用户显式授权后执行。
- 需要联网的校验项，在交付说明中列为「待用户手动确认」，不要自行运行。
- 允许的本地（离线）校验手段：`brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- <file ...>` / `--all`、`brew style <file>`、skill 的 `tests/` 回归测试以及其他 `brew ruby` 加载与断言检查。不使用 `brew audit` / `brew readall` / `brew livecheck` 等 tap 系列命令做验收。
