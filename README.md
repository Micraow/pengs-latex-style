# pengs-template：通用中文大学作业 / 技术文档 LaTeX 模板

适用于两类场景：

1. **作业 / 课程报告**：课程名、作业名、姓名、学号、页眉页脚。
2. **普通 PDF 文档**：说明文字、代码、实验结果、技术笔记、结果汇报等，直接发给别人，不带“作业”语义。

模板目标：同一套视觉系统，不同任务只换入口文件和内容。

---

## 1. 两种入口

### 作业模式

直接从 `main.tex` 开始：

```tex
\documentclass[12pt,a4paper]{scrartcl}
\usepackage{pengs-template}
```

常用元信息：

```tex
\renewcommand{\studentname}{彭勃}
\renewcommand{\studentid}{25371248}
\renewcommand{\coursename}{2026 秋《课程名称》}
\renewcommand{\assignmentname}{作业 01}
```

完整封面：

```tex
\makehomeworktitle
```

紧凑标题：

```tex
\makecompacttitle
```

### 普通文档模式

直接从 `document.tex` 开始：

```tex
\documentclass[12pt,a4paper]{scrartcl}
\usepackage[document]{pengs-template}

\renewcommand{\doctitle}{实验结果说明}
\renewcommand{\docsubtitle}{可选副标题}
\renewcommand{\docauthor}{彭勃}
\renewcommand{\docdate}{2026-09-30}
```

推荐的页首标题：

```tex
\makedocumenttitle
```

如果真的需要独立封面：

```tex
\makedocumentcover
```

普通文档模式页眉显示文档标题，页脚显示作者和页码，不会出现学号、课程、作业之类信息。

---

## 2. `main.tex`、`document.tex`、`example.tex`

- `main.tex`：最小作业骨架。
- `document.tex`：最小普通 PDF 文档骨架。
- `example.tex`：完整示例，展示填空、选择题、公式、代码、表格等。

编译：

```bash
latexmk -xelatex main.tex
latexmk -xelatex document.tex
latexmk -xelatex example.tex
```

模板只支持 XeLaTeX。

---

## 3. 常用作业写法

题目：

```tex
\begin{questions}
  \item 第一题
  \item 第二题
\end{questions}
```

固定宽度填空：

```tex
\blank
\blank[6cm]
```

句末需要自动占满剩余行宽时：

```tex
\blankfill
```

两列选择题：

```tex
\begin{choices}
A、选项 A & B、选项 B \\
C、选项 C & D、选项 D
\end{choices}
```

解答：

```tex
\begin{solution}
推导过程……
\end{solution}
```

留手写空间：

```tex
\answerspace{4cm}
```

---

## 4. 代码

```tex
\begin{lstlisting}[language=Python]
def f(x):
    return x**2
\end{lstlisting}
```

默认已开启自动折行：

- `breaklines=true`
- 长行会折行，不会直接冲出页边距
- 折行位置会显示轻微的箭头提示

当前高亮是柔和冷色系：紫色关键字、青绿色字符串、灰蓝注释、极浅背景。

---

# 5. 表格怎么选

这是模板里最重要的一部分。

## 5.1 横向稍宽，文本列比较多：让“说明性列”自动换行

模板额外提供两种自动伸缩列：

- `Y`：自动分配宽度、自动换行、左对齐；适合长说明文字。
- `C`：自动分配宽度、自动换行、水平居中；适合真值表、对照表等希望整列居中的场景。

例如四列等宽、全部居中的表格可以直接写：

```tex
\begin{xltabular}{\linewidth}{C C C C}
  ...
\end{xltabular}
```

一般说明性表格仍可用 `tabularx`，把文字较多的列写成 `X` 或 `Y`：

```tex
\begingroup
\tablecomfortable
\begin{tabularx}{\linewidth}{@{}l X X r@{}}
\toprule
编号 & 实验条件 & 观察结果与说明 & 数值 \\
\midrule
1 & 室温、默认参数 & 这里可以是一段很长的说明，X 列会自动换行。 & 12.4 \\
2 & 高频负载测试 & 另一段较长说明。 & 19.8 \\
\bottomrule
\end{tabularx}
\endgroup
```

这通常是**保持 A4 竖向页面时最好的办法**。

注意：不要让所有列都换行。

- 说明、备注、名称：适合 `X` / `p{...}` 自动换行。
- 数字、时间、编号、短代码：尽量保持单行。
- 很长 URL：使用 `\url{...}`，模板已加载 `xurl`。

## 5.2 纵向很长，需要自动跨页

用 `xltabular`。它同时具备：

- `longtable` 的跨页能力
- `tabularx` 的 `X` 自动分配宽度 / 自动换行能力

```tex
\begingroup
\tablecomfortable
\begin{xltabular}{\linewidth}{@{}l X X r@{}}
\toprule
编号 & 条件 & 结果说明 & 数值 \\
\midrule
\endfirsthead

\toprule
编号 & 条件 & 结果说明 & 数值 \\
\midrule
\endhead

1 & 条件 A & 很长的说明…… & 10 \\
2 & 条件 B & 很长的说明…… & 20 \\
% 继续很多行

\bottomrule
\end{xltabular}
\endgroup
```

这正适合“横向也不窄、纵向又很多行”的实验结果表。

## 5.3 横向宽，但表格不长，而且内容主要是数字

可以小幅缩放整个表格：

```tex
\begin{adjustbox}{max width=\linewidth}
\begin{tabular}{@{}lrrrrrrr@{}}
...
\end{tabular}
\end{adjustbox}
```

但只建议**小幅缩放**。如果缩到字很小，说明表格本身就不适合硬塞进一页。

另外，`adjustbox` 包住的表格不能跨页，所以它不适合长表。

## 5.4 又特别宽、又特别长，但不想横向页面

不要强行把 15～30 列压成蚂蚁字。优先顺序是：

1. 让描述性列自动换行；
2. 减小列间距 / 用 `\tablecompact`；
3. 把逻辑上不同的列拆成两张表；
4. 拆表时重复关键识别列（如“编号”“样本名”）；
5. 如果仍然无法阅读，再考虑横向页面或附 CSV/XLSX。

也就是说：**自动换行是重要手段，但不是把每个单元格都硬折成多行。**

## 5.5 两个表格密度预设

正常结果表：

```tex
\begingroup
\tablecomfortable
...
\endgroup
```

列很多时：

```tex
\begingroup
\tablecompact
...
\endgroup
```

`\tablecompact` 会适当减字号、减列间距，但不会无限压缩。

---

## 6. 数学、单位、图片

模板已加载 `unicode-math`、`mathtools`、`amsthm`、`siunitx`。

单位示例：

```tex
\qty{60}{\degreeCelsius}
\qty{3.2}{\giga\hertz}
\qty{5}{\volt}
```

图片默认从 `figures/` 查找：

```tex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=.72\linewidth]{example.png}
  \caption{示例图片}
\end{figure}
```

---

## 7. 字体策略

为了避免部分 Arch Linux / XeLaTeX / xdvipdfmx 对 `NotoSansSC-VF.ttf` 的兼容问题，模板现在优先使用**静态思源 CJK 字体**：

- 中文正文：思源宋体 CN → Source Han Serif CN → Noto Serif CJK SC → Noto Serif SC
- 中文标题：思源黑体 CN → Source Han Sans CN → Noto Sans CJK SC → Noto Sans SC
- 中文等宽 fallback：同样优先思源 / CJK 静态字体
- 西文正文：Cambria → Times New Roman → Latin Modern
- 数学：Cambria Math → DejaVu Math TeX Gyre → Latin Modern Math
- 代码：JetBrains Mono → Source Code Pro → Meslo → Latin Modern Mono

模板不附带字体文件。

---

## 8. 文件结构

```text
pengs-template/
├── pengs-template.sty
├── eisvogel-style.sty
├── main.tex                 # 作业最小入口
├── document.tex             # 普通 PDF 文档最小入口
├── example.tex              # 完整示例
├── examples/
├── figures/
├── scripts/
├── latexmkrc
├── Makefile
├── .gitignore
├── README.md
└── AI_GUIDE.md
```

---

## 9. 维护原则

1. 不为每门课重新发明视觉系统。
2. 普通分享文档用 `[document]` 模式，不强行伪装成作业。
3. 宽表优先调整列结构，而不是默认旋转整页。
4. 长表优先 `xltabular` 跨页。
5. 老师明确规定格式时，以老师要求为准。
6. 不编辑 `.aux`、`.log`、`.xdv`、`.fls` 等编译产物。
