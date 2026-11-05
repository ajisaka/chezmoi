---
name: md-post
description: セッションで調べた内容や成果物を Markdown にまとめてローカルファイルに書き出す。
disable-model-invocation: true
allowed-tools: Write, Read, Glob, Skill, Bash(echo $CLAUDE_CODE_SESSION_ID)
---

# md-post

セッションで調べた内容を Markdown でまとめ、ローカルのファイルに書き出す。

## 手順

1. まとまった日本語の散文を含む場合は、本文を書く前に `japanese-tech-writing` スキルを参照する (下記「文章規範」参照)
2. 保存対象の内容を Markdown にまとめる
3. 下記の規則に従って出力先パスを決定
4. `Glob` または `Read` で同一パスの既存ファイルの有無を確認
5. なければ `Write` で新規作成、あればユーザに確認のうえ上書き

## 文章規範

調査レポート、解説、議論のまとめなど、地の文の段落が含まれる文書を書くときは、`japanese-tech-writing` スキルの規範 (一文一行、パラグラフライティング、ダッシュ・中黒の禁止、LLM っぽい空句の排除など) に従う。

箇条書きだけの短いメモ、コマンド出力やログの貼り付け、表が本体の文書では参照しなくてよい。

## 出力先の規則

- 既定: カレントディレクトリ直下の `{title}.md` (`{title}` = 主題を表す簡潔な名前)
- `$ARGUMENTS` でディレクトリ名・ファイル名が指定されていれば、それを優先する
- `{title}` にスラッシュ `/` を含めない。含まれていたら半角スペースまたはハイフンに置換
- 分類してツリーに置くよう指示された場合のみ、種類別のディレクトリを使う (上から優先):
  - 何かの紹介: `ai/pick/{category}/{title}.md` (`{category}` = book/gadget/tool/music など)
  - 調査・分析レポート: `ai/report/common/{title}.md`
  - セキュリティチェック: `ai/report/security/{title}.md`
  - ニュース: `ai/news/{title}/{range}.md` (`{range}` = 日付範囲などの補足情報)
  - YouTube 動画要約: `ai/summary/youtube/{title}.md` (`{title}` = 動画タイトル)
  - ユーザとの議論のまとめ: `ai/discussion/{category}/{title}.md` (`{category}` = philosophy/politics/mathematics など)
- 出力先ディレクトリを `Glob` で確認し、既存ファイルの命名を踏襲すること
- 迷うときは、案をだして、提案すること

## 文書の形式

- 1 行目を H1 のタイトルとし、空行をはさんで本文を書く
- Front Matter は書かない。タグも付けない
  - 分類は出力先のディレクトリとファイル名で表す
- 他ドキュメントへのリンクは、そのファイルへの相対パスを使う
- ディレクトリ構成から親子が辿れる場合、親子関係のリンクをいちいち貼らないこと

## セッション情報の保持

Claude Code のセッションを後から再開できるように、ドキュメントの最後に↓のような節を追加します。

`${CLAUDE_CODE_SESSION_ID}` は git commit 手順内の `Claude-Session: https://claude.ai/code/session_{ID}` の ID (`CLAUDE_CODE_BRIDGE_SESSION_ID`) とは別物なので、そこから流用しない。必ず `Bash(echo $CLAUDE_CODE_SESSION_ID)` を実行し、その出力（UUID形式）を使う。

`claude --resume` はカレントディレクトリに依存せずマシン上の全プロジェクトを横断検索するため、`cd` は不要。

    ---
    # Claude Code Session
    ```
    claude --resume ${CLAUDE_CODE_SESSION_ID}
    ```

## 優先される追加指定

$ARGUMENTS
