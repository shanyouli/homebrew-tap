---
name: homebrew-packaging
description: >
  在 Homebrew tap 中创建、新增或更新 cask/formula，根据软件名称、上游仓库、版本或发布下载链接
  生成配方，确认架构、系统要求、SHA-256、安装产物和 zap，并运行不依赖 tap 注册的离线审计。
  当用户要求添加 Homebrew 配方、编写 cask/formula 或更新软件版本时使用。
  优先离线验证，仅为补齐必要元数据或安装产物信息联网；遵守项目联网授权限制。
  不用于仅安装软件、brew 环境排障、纯命令解释或只审查现有改动。
compatibility: 校验需要本机已安装 Homebrew 及其 Ruby 审计和样式依赖；不自动安装依赖。
---

# Homebrew 配方创建与更新

## 目标与范围

创建最小、可维护、有证据支持的配方，优先复用项目验证工具，不为了单个新配方生成临时审计命令。
默认输出代码与验证结果，不执行安装、不自行提交。

本 skill 与脚本属于项目资源。文中的 `scripts/`、`tests/`、`references/` 路径均相对于本 skill 目录，
不是项目根目录。执行前用本 skill 的实际路径解析绝对路径。

## 输入与触发

- 接受软件名、上游仓库 URL、指定版本、发布页或下载 URL；优先从已有配方和可信上游补齐缺项。
- 用户指定版本时固定该版本，不因发现更新版本而擅自升级。
- 用户只给软件名且存在同名项目时，先确认上游；不要猜仓库或下载域名。
- 当主要任务为安装、系统排障、纯说明或代码审查时，不执行此创建流程。

## 硬边界

1. **先读项目 `AGENTS.md`、Git 状态和同类配方。** 项目规则比通用建议更具体；发生冲突时指出并请求用户选择。
2. 不修改已安装 tap 的副本，不为文件级校验创建、替换或软链 tap，不混入用户已有改动。
3. 不编造 SHA-256、Intel 下载 URL、bundle identifier、最低系统要求或清理路径。
4. 不通过 `sha256 :no_check`、占位摘要、弱化系统要求或跳过审计掩盖缺失信息。
5. 不自动安装校验依赖，不静默修改缓存策略或信任配置；依赖缺失时报告阻塞。
6. 仅加载可信本地 Ruby 配方。内容加载不是安全沙箱；不执行下载包里的程序、安装器或发布脚本。
7. 不把离线审计通过说成真实安装、签名、公证或跨平台验证通过。
8. 只有用户当轮明确要求提交，才使用提交工具；用户告知上次已提交不构成本轮授权。

## 联网策略：必要信息可以查，验收默认离线

先判断缺少的信息是否影响配方正确性，再选择最小请求。联网前说明目的，不重复查询已确认的内容。
**本 skill 不授予绕过项目或工具权限的能力。** 若项目要求每次联网明确授权，查询 API、文档和下载都先取得授权。
用户要求“生成配方”或提供 URL，不自动等同于批准安装、重装或在线审计。

| 操作 | 使用条件 |
| --- | --- |
| 查询官方文档、发布 API、固定版本的源码配置 | 本地证据不足，且需要确认版本、摘要、架构、安装产物或数据目录；允许必要、定向查询 |
| 用 `scripts/inspect.rb` 下载安装包到 Homebrew 缓存（不安装） | 本地证据不足以确认 app 名称、bundle id、最低系统版本、架构、签名或 zap 候选时；请求用户当次授权（或交由用户自行运行）；只读检查，绝不安装 |
| 人工解包或只读查看安装包 | inspect.rb 仅支持 DMG；其他格式（zip、pkg 等）人工解包后用 `--file` 复核，不启动软件 |
| `brew livecheck`、`brew audit --online`、`brew audit --new` | 不是默认验收；确需时取得当轮明确授权。`--new` 不能当离线严格检查使用 |
| `brew install`、`reinstall`、`upgrade`、实际 `test do` | 改变环境或执行软件；只有用户单独要求/授权才执行 |

优先官方 API 和源码，不用搜索摘要代替安装元数据。需搜索时用英文定向查询，读取找到的官方原文。
工具只能提供解释性摘要、访问失败或证据冲突时，先说明不确定性，不把推测填入配方。

## 标准流程

### 1. 勘察与分类

- 查看项目规则、工作树状态、`Casks/`、`Formula/`、README 和现有验证脚本；只读最相关的同类文件。
- 检查同名配方是否已存在或归档，确定是新增、更新还是恢复，避免重复创建。
- 桌面 app、DMG/app 安装分发一般使用 cask；源码构建和命令行工具一般使用 formula。
  按软件实际安装方式判断，不把用户口语中的“配方”机械解释为 `Formula`，也不只凭文件扩展名判断。
- 确认输出 token、文件名、用户指定版本及本次改动范围。

### 2. 获取摘要与发布信息

对于 GitHub Releases，优先查询用户指定的 tag：

```text
https://api.github.com/repos/<owner>/<repo>/releases/tags/<tag>
```

- 从 `assets` 中精确匹配目标文件的 `name` 和 `browser_download_url`，不要取源码归档或 `.sig` 的摘要。
- 检查 `digest` 是否为非空 `sha256:<64 位十六进制>`，可用时去掉 `sha256:` 前缀写入配方。
- 摘要来自 API 时记录这一来源；没有下载并自行计算就不要声称“已重新校验安装包”。
- `digest` 缺失、为空、格式不正确时，先找可信 SHA-256 清单或精确版本的本地缓存，再按联网策略下载目标包计算。
- MD5 清单、签名文件内容和 app 归档摘要不能代替对应 DMG 的 SHA-256。
- 授权运行 inspect 后，脚本会在本地实测下载文件的 SHA-256：与 API digest 一致即双重确认，不一致时立即停下核对（asset 可能被替换）。
- 只为需求所需的架构生成分支；只有 aarch64 安装包时不要推测存在 x64 包。

非 GitHub 上游按同一原则处理：用户指定版本、精确 artifact、可信摘要、最小下载。

### 3. 核对安装与卸载元数据

证据优先级：制品检查（授权后下载到缓存）→ 固定 tag 的上游源码/打包配置 → 上游维护的 cask → 本机安装痕迹。
制品检查天然对应精确版本，不受主分支演进影响；源码检索只作补充或回退，且须对照固定 tag。

需要联网确认制品信息时，用 skill 的 `scripts/inspect.rb` 检查草稿配方（下载到 Homebrew 缓存，不安装）：

```sh
# 下载并只读检查（按项目联网约定取得当次授权后执行，或交由用户自行运行）
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/scripts/inspect.rb -- Casks/winc.rb

# 指定架构解析多架构配方
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/scripts/inspect.rb -- Casks/winc.rb --arch x64

# 离线复用缓存或已有安装包，不联网
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/scripts/inspect.rb -- --file ~/Library/Caches/Homebrew/downloads/<已缓存的.dmg>
```

输出包括：实际 app 名称、CFBundleIdentifier、LSMinimumSystemVersion、Mach-O 架构、签名与公证状态、
配方版本与制品版本的一致性，以及按 bundle id 生成的 zap 候选。

- `app`/binary 名称以制品为准，不凭 DMG 文件名猜（如 Winc 的 DMG 叫 `Winc-*.dmg`，包内是 `winc.app`）。
- `LSMinimumSystemVersion` 记入交付说明；本仓库 `Homebrew/OSDependsOn` cop 判定 cask 中的最低 macOS 版本冗余，配方统一写 `depends_on :macos`。
- 签名与公证状态来自 inspect 的 codesign 检查，据此决定是否需要 Gatekeeper caveat。
- `zap`：inspect 输出的候选只是候选，逐项需要运行时或源码证据；候选与实际证据冲突时以实际证据为准
  （如应用按产品名而非 bundle id 存数据：Winc 的候选是 `com.deeix.winc`，实际写入 `Application Support/winc`）。
  无证据不写入。不因为 bundle id 看起来合理就补齐所有常见目录；不使用宽泛通配符，不删除用户文档、Markdown 笔记或共享数据。
- 配置目录包含未保存内容/恢复数据时，说明 `zap` 会删除哪些数据。无法确认路径时报告缺项，不捏造，也不冒称 `zap :not_required`。
- pkg/installer 的卸载应依据上游安装行为确认，不能直接照搬 app 的卸载策略；inspect 仅支持 DMG，其他格式人工解包。

### 4. 编写最小配方

**cask：**
- 保持 token 与文件名一致，填写版本、准确摘要、可插值 URL、name、desc、homepage。
- macOS 专属应用必须声明 `depends_on :macos`：否则跨平台加载会因 `sha256` 解析为 nil 报 `Invalid cask`；单架构发行明确声明架构依赖。
- 最低 macOS 版本来自制品的 `LSMinimumSystemVersion`：本仓库 `Homebrew/OSDependsOn` cop 视 cask 中的最低版本为冗余，配方统一只写 `depends_on :macos`
  （`:catalina` 及更低版本符号已进 `DISABLED_MACOS_VERSIONS`，加载即抛异常），版本要求写进交付说明。
- `livecheck` 根据真实 tag/发布策略编写，但默认只校验声明，不联网执行。
- 不使用已弃用的 `preflight` / `postflight`，改用 `preflight_steps` / `postflight_steps` / `uninstall_preflight_steps` / `uninstall_postflight_steps`；
  其中写文件用 `write_file`（默认 `base: :staged_path`，内容中 `#{appdir}` 改用 `{{appdir}}` 模板变量），不用 `File.write`。
- stanza 顺序以 Homebrew 的 `STANZA_GROUPS` 为准（`arch`/`version`/`url` 信息组 → `livecheck` → `auto_updates`/`conflicts_with`/`depends_on` →
  artifact 组 → `*_steps` → `uninstall` → `zap` → `caveats`），错位会被 `Cask/StanzaOrder` 判违规。
- 按证据添加 app/binary、uninstall、zap；不盲信 `brew style --fix`（如对 `Cask/Desc` 的自动修正会产出不通顺文案），须人工复核修正结果。
- 排查校验失败时按根因归类：一个 stanza 缺陷可能连带多条报错，不要按报错条数判断问题数量。

**formula：**
- 类名与文件名对应，明确稳定版本来源、SHA-256、homepage、desc 和有证据的 license。
- 只声明真实的构建/运行依赖，按项目惯例编写 `install` 与有意义的 `test do`。
- 新增或修改方法时补充项目风格的功能/参数/返回值说明；编写测试不等于默认执行它。

两类配方均按项目约定更新 README，避免无关改动。网络失败或关键元数据缺失时保留阻塞状态。

### 5. 离线验证

先使用项目 `AGENTS.md` 指定的验证入口；没有其他约定时使用本 skill 的 `scripts/validate.rb`。
当前项目从仓库根目录运行：

```sh
# 多个文件可混合两类配方
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- Casks/nomo.rb Formula/mole.rb

# 目录递归扫描；用于需要扩大检查范围时
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- Casks/ Formula/

# 全仓库扫描，需要明确选择，默认不执行
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/scripts/validate.rb -- --all
```

- 默认必须指定文件/目录；`--all` 不能与路径混用，且锚定**脚本所在 Git 仓库**，不取调用目录。
- 使用其他项目的 skill 副本时，要先确认脚本所属仓库；验证不同目标仓库时传其明确文件/目录，不使用 `--all`。
- 退出码：`0` 全部通过，`1` 审计/样式失败，`2` 参数或环境错误。逐项修复并重跑相关文件。
- 脚本按内容加载 cask/formula，执行严格审计后批量检查样式；不注册 tap，也不自动修复或安装依赖。
- 不重新生成 `brew ruby -e` 审计命令，不复制出第二套验证实现。Homebrew 内部 API 变化时修复附带脚本并运行测试。
- 离线开关不是网络隔离：可信 Ruby 本身及依赖解析可能有额外行为，缺少本地依赖元数据时先报告；
  不允许以“审计是离线的”为由放行隐含下载。无 Homebrew/校验依赖时明确标为未验证。
- tap 级审计和跨 OS × 架构模拟不在脚本范围内，也不作为本仓库验收手段；用户明确要求扩大检查时，先说明局限与联网代价再执行。

### 6. 交付

给出：
1. 修改文件、版本、平台/架构和关键安装/清理信息。
2. SHA-256 与关键元数据的来源；单来源或未经安装包实测的限制。
3. 执行的验证命令、退出码、失败/阻塞项。
4. 待用户手动执行的联网/安装检查；不要冒称全部验收通过。
5. 是否提交；未获当轮授权时保持未提交。

## 自检与回归

- [ ] 类型、token、版本和 artifact 精确匹配。
- [ ] 摘要有来源，架构和系统要求不是推测。
- [ ] app/binary/uninstall/zap 的关键路径有依据。
- [ ] 没有跨版本套用元数据或删除用户文档的通配符。
- [ ] 项目规则与必要联网授权边界已遵守。
- [ ] 文件级审计、样式及 diff 检查通过，未知项明确披露。

迁移或修改验证脚本后执行：

```sh
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/tests/validate_test.rb
HOMEBREW_NO_AUTO_UPDATE=1 brew ruby .agents/skills/homebrew-packaging/tests/inspect_test.rb
```

查看 [评估用例](references/evaluation.md) 检查触发准确性、联网边界与交付质量。
