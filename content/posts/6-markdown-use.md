+++
title = "markdown 常用语法整理"
date = "2021-11-14"
description = "整理记录 markdown 常用语法，方便长时间不写 markdown 文档，忘记语法时，能快速查阅。"

[taxonomies]
tags = ["Tools"]
+++

整理记录 markdown 常用语法，方便长时间不写 markdown 文档，忘记语法时，能快速查阅。

## 表格
1. 添加表，使用三个或多个连字符（---）创建每列的标题，并使用管道（|）分隔每列。您可以选择在表的任一端添加管道
2. 对齐表，通过在标题行中的连字符的左侧，右侧或两侧添加冒号（:），将列中的文本对齐到左侧，右侧或中心
3. 转义管道字符，以使用表格的 HTML 字符代码（&#124;）在表中显示竖线（|）字符
4. 格式化展示表格，使用 vscode  `Markdown All in one` 插件，右键格式化文档

```
| Tables   |        Are        |  Cool |
| -------- | :---------------: | ----: |
| col 1 is | left&#124;aligned | $1600 |
| col 2 is |     centered      |   $12 |
| col 3 is |   right-aligned   |    $1 |
```

| Tables   |        Are        |  Cool |
| -------- | :---------------: | ----: |
| col 1 is | left&#124;aligned | $1600 |
| col 2 is |     centered      |   $12 |
| col 3 is |   right-aligned   |    $1 |

## 链接
1. 链接文本放在中括号内，链接地址放在后面的括号中，链接title可选。
2. 使用尖括号可以很方便地把URL或者email地址变成可点击的链接。

```
这是一个链接 [Markdown语法](https://markdown.com.cn)。
<https://markdown.com.cn>
<fake@example.com>
```

这是一个链接 [Markdown语法](https://markdown.com.cn)。

<https://markdown.com.cn>

<fake@example.com>

## 任务列表
要创建任务列表，请在任务列表项之前添加破折号-和方括号[ ]，并在[ ]前面加上空格。要选择一个复选框，请在方括号[x]之间添加 x
```
- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media
```
- [x] Write the press release
- [x] Update the website
- [ ] Contact the media

## 参考
<https://markdown.com.cn/extended-syntax/availability.html>