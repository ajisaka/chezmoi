---
name: viv
description: Use when the user wants to preview or view a Markdown file in the browser. Opens the file with Vivify. If no argument is given, opens the last file written in this session.
allowed-tools: Bash(viv *)
---

# viv

Markdown ファイルをブラウザでプレビュー表示する（Vivify）。

## 手順

1. **対象ファイルの決定**
   - `$ARGUMENTS` が指定されていればそのパスを使う
   - 未指定の場合、このセッション中に Write ツールで最後に作成・更新したファイルを使う
   - 対象が見つからなければユーザーに聞く

2. **表示**
   ```bash
   viv "$FILE_PATH"
   ```
   特定の行にスクロールしたい場合は `:行番号` を付ける（例: `viv report.md:42`）。
