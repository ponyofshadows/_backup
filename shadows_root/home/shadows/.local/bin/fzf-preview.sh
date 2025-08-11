
#!/usr/bin/env bash
# 适配 Kitty 终端的 fzf 文件预览脚本（无乱码、无报错）

MAX_PREVIEW_LINES=200
MAX_FILE_LINES=2000
FILE="$1"

[ -e "$FILE" ] || exit 0

# 目录预览
if [ -d "$FILE" ]; then
    ls --color=always -A "$FILE" | head -n $MAX_PREVIEW_LINES
    exit 0
fi

MIME=$(file --mime-type -b "$FILE")

# 文本预览
if [[ "$MIME" == text/* ]] || [[ "$MIME" == */xml ]]; then
    LINES=$(wc -l < "$FILE")
    if (( LINES > MAX_FILE_LINES )); then
        bat --style=numbers --color=always --line-range :$MAX_PREVIEW_LINES "$FILE"
        echo -e "\n--- 文件过大，只预览前 $MAX_PREVIEW_LINES 行（共 $LINES 行） ---"
    else
        bat --style=numbers --color=always "$FILE"
    fi
    exit 0
fi

# 图片预览（Kitty）
if [[ "$MIME" == image/* ]]; then
    term_w=$(tput cols)
    term_h=$(tput lines)
    x=$(( term_w * 40 / 100 ))   # 左 40% 给 fzf 列表
    y=1
    w=$(( term_w - x ))
    h=$term_h

    timeout 2s kitty +kitten icat \
      --stdin=no \
      --transfer-mode=file \
      --place "${w}x${h}@${x}x${y}" \
      --scale-up \
      --clear \
      "$FILE" 2>/dev/null || true
    exit 0
fi

# PDF 预览（转成第一页 PNG）
if [[ "$MIME" == application/pdf ]]; then
    TMP_PNG="/tmp/fzf_preview_${RANDOM}.png"
    pdftoppm -png -singlefile -rx 150 -ry 150 "$FILE" "${TMP_PNG%.png}" >/dev/null 2>&1

    term_w=$(tput cols)
    term_h=$(tput lines)
    x=$(( term_w * 40 / 100 ))
    y=1
    w=$(( term_w - x ))
    h=$term_h

    timeout 4s kitty +kitten icat \
      --stdin=no \
      --transfer-mode=file \
      --place "${w}x${h}@${x}x${y}" \
      --scale-up \
      --clear \
      "$TMP_PNG" 2>/dev/null || true

    rm -f "$TMP_PNG"
    exit 0
fi
# 其他类型
echo "文件类型: $MIME"
file "$FILE"
