#!/usr/bin/env bash
set -euo pipefail

fonts=(
  "Cambria"
  "Cambria Math"
  "Times New Roman"
  "Source Han Serif CN"
  "思源宋体 CN"
  "Noto Serif SC"
  "Source Han Sans CN"
  "思源黑体 CN"
  "Noto Sans SC"
  "JetBrainsMono Nerd Font"
  "Source Code Pro"
  "MesloLGS NF"
  "DejaVu Math TeX Gyre"
)

printf '%-30s %s\n' "候选字体" "fontconfig 匹配结果"
printf '%-30s %s\n' "------------------------------" "----------------------------------------"
for f in "${fonts[@]}"; do
  printf '%-30s %s\n' "$f" "$(fc-match -f '%{family[0]} / %{style[0]}\n' "$f" | head -n1)"
done
