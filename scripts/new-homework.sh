#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "用法: $0 <新作业目录>" >&2
  exit 2
fi

src="$(cd "$(dirname "$0")/.." && pwd)"
dst="$1"

if [[ -e "$dst" ]]; then
  echo "目标已存在：$dst" >&2
  exit 1
fi

mkdir -p "$dst/figures"
cp "$src/pengs-template.sty" "$dst/"
cp "$src/eisvogel-style.sty" "$dst/"
cp "$src/main.tex" "$dst/"
cp "$src/example.tex" "$dst/"
cp "$src/document.tex" "$dst/"
cp "$src/latexmkrc" "$dst/"
cp "$src/Makefile" "$dst/"
cp "$src/.gitignore" "$dst/"
cp "$src/README.md" "$dst/"
cp "$src/AI_GUIDE.md" "$dst/"
touch "$dst/figures/.gitkeep"

echo "已创建：$dst"
echo "下一步：cd '$dst' && \$EDITOR main.tex && latexmk -xelatex main.tex"
