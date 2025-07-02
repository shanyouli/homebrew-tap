#!/bin/bash

set +e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cask=$1

echo "Checking for $cask..."

# "sed" command not working on github action,
# because of the color code in the output of "brew livecheck --cask" command
brewCheck=$(brew livecheck --cask "$cask")
echo "[BrewCheck]: $brewCheck"

# if brewCheck contain "skipped", exit
if [[ $brewCheck == *"skipped"* ]]; then
  echo "Skipped for $cask"
  exit 0
fi

formatCheck=$(echo "$brewCheck" | tr -d ' ' | cut -d':' -f2-)
echo "[FormatCheck]: $formatCheck"
cleanCheck=$(echo "$formatCheck" | sed 's/\x1b[[0-9;]*m//g')
echo "[CleanCheck]: $cleanCheck"

fromV=${cleanCheck%==>*}
toV=${cleanCheck#*==>}

echo "Updating $cask from $fromV to $toV"
if [[ "$fromV" != "$toV" ]]; then
  if ! brew bump-cask-pr "$cask" --version "$toV" --verbose 2>&1 ; then
    echo "$cask 更新到 $toV 失败，请检查该 casks." >> "$DIR"/../../../error.log
  fi
fi
ls "$DIR"/../../..
echo "Done for $cask"
