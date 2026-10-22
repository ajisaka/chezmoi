---
name: commit
description: Stage and commit changes with logical splitting per Conventional Commits.
disable-model-invocation: true
allowed-tools: Bash(git *), Read
---

## 手順

1. `git status` で未追跡ファイル含む全体を把握、`git diff` と `git diff --staged` で内容確認
2. 論理的に独立した変更単位を洗い出す
3. ファイル単位の `git add <file>` でステージング (`git add -p` は対話的なので不可。hunk 分割が必要なら patch ファイル経由で `git apply --cached`)
4. シークレット/認証情報 (`.env`, `credentials.*`, API キー等) が混入していないか確認、見つかれば中断して報告
5. Conventional Commits 形式でコミットメッセージ作成 (HEREDOC を使う)
6. 分割単位などで、迷う場合はユーザに確認する (基本的には細かく分ける方針、迷う余地がなければいちいち聞かないこと!)
7. 不審・不適切な変更を発見した場合は、コミット前に内容を提示して中断する

## コミットメッセージの言語

- `git log --oneline -10` で過去ログを確認し、英語/日本語を判断する
- ログがない/混在している場合はユーザに確認する

## 追加指示

$ARGUMENTS
