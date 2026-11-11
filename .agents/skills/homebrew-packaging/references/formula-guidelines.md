# formula 编写准则

以本机 Homebrew 的 Formulary/FormulaAuditor 为准。编写前通读本文；
新 formula 以“骨架例子”节列出的真实配方为骨架（已通过全量验证），按实际证据填充。

## 基础字段

- 类名与文件名一致（`mole.rb` → `class Mole`），token 全小写。
- 必填：`version`、`url`、`sha256`、`homepage`、`desc`、`license`。
- `desc` 英文小写开头、不以 token 开头、一句话功能描述。
- `license` 用 SPDX 表达式（`MIT`、`Apache-2.0`、`GPL-3.0-or-later` 等）；以仓库实际许可证为准。
- `homepage` 带协议；项目主页优先，其次仓库页。

## 版本与下载

- 优先 GitHub Releases：release tarball（`archive/refs/tags/`）或 release asset 均可；
  tag 前缀（`v`/`V`）按上游实际大小写用 `#{version}` 插值
  （mole：`V#{version}` 大写；yabai：asset 路径含 `v#{version}`）。
- SHA-256 从 release API `digest`、上游校验清单或下载实测获取，不编造；来源记入交付说明。
- 用户指定版本时固定该版本，不因 latest 更新而升级。
- `head "https://github.com/<owner>/<repo>.git"` 可选；个人 tap 一般只写 stable。

## 依赖

- 区分构建/运行依赖：`depends_on "rust" => :build`；产物自包含时不要声明运行时依赖。
- `depends_on :macos`：本仓库 formula（mole、yabai）均声明 macOS 依赖。
  与 cask 不同，formula 中最低 macOS 版本（`depends_on macos: :ventura`）不会被判冗余，
  仅真实需要时写（如使用了新系统 API）。
- 不为"可能有帮助"的依赖加项；声明前先构建验证。

## install 方法

- 用 DSL 而非裸 shell 拼路径：`bin.install`、`libexec.install`、`share.install`、
  `man1.install`、`(pkgshare/"examples").install`。
- 修改脚本/配置中的硬编码路径用 `inreplace`，不要 `sed -i`。
- 构建命令用 `system "make", "install"` 形式（参数逐个传递，不用字符串拼接）。
- head 构建产物需本地签名时参考 yabai 的 `system "codesign", "-fs", "-", ...`。

## caveats

- 用 `def caveats` 方法 + heredoc；只写用户安装后需要知道且有证据的事项
  （权限要求、服务管理命令、配置文件位置、更新方式），无证据不写。

## test do

- 必须有意义：验证二进制可执行、版本输出（`assert_match version.to_s, shell_output("#{bin}/mole --version")`）
  或 `--help` 等基本行为；yabai 先例用 `assert_match "yabai-v#{version}", ...` 适配上游版本号格式。
- 不依赖网络、不写用户目录；编写测试不等于默认执行（离线验证不运行 `test do`）。

## livecheck

- `url "https://github.com/<owner>/<repo>"` + `strategy :github_latest`；
  需要自定义提取时写 `regex`（可先注释保留草稿，见 mole 先例）。

## 验证

- 与 cask 相同：validate.rb 内容审计 + 样式检查（SKILL.md 第 5 步）；
  排错按根因归类，一个缺陷可能连带多条报错。

## 最小配方模板

新 formula 从最小配方模板创建（模板相对本 skill 目录）：复制 `references/formula-template.rb` 到
仓库根 `Formula/<token>.rb`，类名 = 文件名首字母大写，按证据填充占位符并删除未用注释行，
再跑 SKILL.md 第 5 步验证。

模板只含最小可加载结构；`libexec` + `inreplace`、release asset URL、`man`/`pkgshare`、`head`
等扩展写法，参照填充后的真实成品：仓库根 `Formula/mole.rb`（完整骨架例）、`Formula/yabai.rb`（asset URL + man/pkgshare 例）。

提交前用 `grep '<' Formula/<token>.rb` 确认占位符已全部替换（类名 `Token` 也要改）。
