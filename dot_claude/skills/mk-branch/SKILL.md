---
name: mk-branch
description: Decide a branch name from the current changes and instructions, then create the branch.
disable-model-invocation: true
allowed-tools: Bash(git *), Read, Grep, Glob
---

## 手順

1. 現状把握: `git status`、`git diff`、`git diff --staged` で未追跡ファイルを含む変更内容を確認する。変更がまだ無い場合は `$ARGUMENTS` の指示内容を名前の根拠にする
2. 命名規則の確認 (**作業中のリポジトリ**のルールが最優先):
   - リポジトリ内の `CLAUDE.md`、`AGENTS.md`、`CONTRIBUTING.md`、`README.md`、`docs/`、`.github/` に branch 命名の記述があるか検索する
   - `git branch -a --sort=-committerdate` と `git log --oneline --merges --all` で既存ブランチ・過去のマージ元の命名慣習 (prefix、区切り文字、issue 番号の有無、英語/ローマ字) を読み取る
   - 複数の流儀が混在していたら新しいもの・多数派に合わせる
3. ルールも慣習も見つからない場合のみ、`<type>/<summary>` を既定とする:
   - `type` は Conventional Commits と同じ語彙 (`feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `perf`, `ci`)
   - `summary` は英小文字の kebab-case、2〜4 語。対象と内容が分かる具体名にする (例: `fix/login-redirect-loop`)
   - 日付・ユーザ名・issue 番号は、既存ブランチにその慣習がある場合のみ付ける
4. `$ARGUMENTS` でブランチ名そのものが指定されている場合はそれを使う。命名規則に反する部分だけ調整し、調整したら報告する
5. 分岐元の確認: 現在のブランチがデフォルトブランチ (`git symbolic-ref refs/remotes/origin/HEAD` 等で判定) でなければ、どこから切るかユーザに確認する
6. `git switch -c <name>` で作成する (未コミットの変更はそのまま持ち越される)。同名のブランチやリモート追跡ブランチが既に存在する場合は中断して報告する
7. 作成したブランチ名と、その名前にした根拠 (どのルール・慣習に従ったか) を一行で報告する

## 判断に迷う場合

- 変更が無関係な複数の作業を含み 1 つの名前に収まらない: 候補を提示してユーザに確認する (勝手に分割やコミットをしない)
- 変更内容から目的が読み取れない: 推測で命名せず、何の作業かユーザに聞く

## 追加指示

$ARGUMENTS
