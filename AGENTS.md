# 指令

## 校验约定

- `brew audit` 离线优先：本地校验 cask/formula 时默认不加 `--online`，避免触发资源下载与网络请求以加快校验速度。仅当确需验证下载 URL、在线资源或 livecheck 在线行为时，才显式追加 `--online`。
- 修改或新增 cask/formula 后，提交前先用 `brew audit`（离线）与 `brew livecheck` 自测通过。
