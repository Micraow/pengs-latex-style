# AI / Agent 编辑约定

## 先判断文档类型

### 课程作业 / 作业报告

使用：

```tex
\usepackage{pengs-template}
```

优先从 `main.tex` 开始。

### 普通分享 PDF / 技术说明 / 实验结果 / 代码说明

使用：

```tex
\usepackage[document]{pengs-template}
```

优先从 `document.tex` 开始。不要强行添加课程名、作业号、学号。

## 固定规则

1. 编译器固定为 XeLaTeX。
2. 默认只改入口 `.tex` 的元信息和正文；除非用户明确要求，不改 `pengs-template.sty`。
3. `example.tex` 是展示能力的完整示例，不应当直接当正式作业内容提交。
4. 不编辑 `.aux`、`.log`、`.fls`、`.fdb_latexmk`、`.xdv`、`.synctex.gz`。
5. 图片放 `figures/`。
6. 不把 Markdown 语法混进 LaTeX。
7. 单位优先 `siunitx`。
8. 题目用 `questions`，两列选项用 `choices`，解答用 `solution`。
9. 填空题一律用 `\fillin[宽度]{答案不填，留空}` ，不要使用 `\blank`/`\blankfill` 只留空。
10. 代码块在单个 `lstlisting` 指定语言。长代码行默认自动折行。

## 表格决策规则

- 普通短表：`tabular` / `tabularx`。
- 有长文字列：把说明列设为 `X` 或左对齐自动伸缩列 `Y`，允许自动换行。
- 真值表、对照表等需要自动分配宽度且整列居中：使用 `C`；例如 `{C C C C}`。
- 行数很多、要跨页：`xltabular`。
- 短但略宽的纯数值表：可用 `adjustbox` 的 `max width=\linewidth` 小幅缩放。
- 又宽又长：先自动换行说明列，再减列间距，再按逻辑拆成多张表并重复关键索引列。
- 不要为了“塞进去”把所有列都变成极窄多行，也不要默认旋转页面。
- `adjustbox` 包裹的表不能跨页，不用于长表。

## 修改后的自检

- XeLaTeX 无 error；
- 没有 Overfull hbox 导致内容越界；
- 长代码自动折行；
- 长表能跨页；
- 描述性列可以换行，数字列仍保持易读；
- 普通文档中没有不相关的学号 / 作业信息；
- 不新增字体文件。
