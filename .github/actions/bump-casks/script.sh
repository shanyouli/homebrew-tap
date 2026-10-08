#!/bin/bash

set +e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cask=$1

echo "Checking for $cask..."

brewCheck=$(brew livecheck --cask "$cask")
echo "[BrewCheck]: $brewCheck"

# if brewCheck contain "skipped", exit
if [[ $brewCheck == *"skipped"* ]]; then
  echo "Skipped for $cask"
  exit 0
fi

# brew livecheck 的输出带 ANSI 颜色码，先去掉空格再剥掉颜色码再解析 "from ==> to"
formatCheck=$(echo "$brewCheck" | tr -d ' ' | cut -d':' -f2-)
echo "[FormatCheck]: $formatCheck"
# shellcheck disable=SC2001  # 去掉 ANSI 颜色码只能用 sed
cleanCheck=$(echo "$formatCheck" | sed 's/\x1b\[[0-9;]*m//g')
echo "[CleanCheck]: $cleanCheck"

fromV=${cleanCheck%==>*}
toV=${cleanCheck#*==>}

# 解析失败（livecheck 输出格式变化、上游 404 等）时不要把垃圾版本号提交成 PR
if [[ -z "$toV" || ! "$toV" =~ ^[0-9] ]]; then
  echo "[Skip] $cask: 无法从 livecheck 输出解析出新版本号，跳过"
  exit 0
fi

echo "Updating $cask from $fromV to $toV"
if [[ "$fromV" != "$toV" ]]; then
  if ! brew bump-cask-pr "$cask" --version "$toV" --verbose 2>&1 ; then
    echo "$cask 更新到 $toV 失败，请检查该 casks." >> "$DIR"/../../../error.log
  fi
fi
echo "Done for $cask"
