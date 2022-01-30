#!/bin/bash

readonly TARGET_DIR=$(defaults read com.apple.screencapture location)
readonly DEFAULT_PREFIX=$(defaults read com.apple.screencapture name)

if [[ ! -d $TARGET_DIR ]]; then
  echo "[error] Not Found target directory ${TARGET_DIR}" >&2
  exit
fi

fswatch -0 $TARGET_DIR | while read -d "" input_path; do
  if [[ ! ${input_path} =~ ^$TARGET_DIR/\. ]]; then
    from=${input_path}
    to=$(echo ${input_path} | LC_COLLATE=C.UTF-8 sed -e s:"/${DEFAULT_PREFIX} ":/:g | sed -e s:" ":_:g)

    # ファイルが削除される時も検出されてしまって mv の対象がなくなるので、エラー出力は捨てる
    mv -n "${from}" "${to}" 2>/dev/null
  fi
done &