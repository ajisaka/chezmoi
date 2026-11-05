-- 保存のたびにタイムスタンプ付きバックアップを自動作成し、ファイルの全変更履歴を保持する。
return {
  'aiya000/bakaup.vim',
  event = 'InsertEnter',
  init = function()
    vim.g.bakaup_auto_backup = 1
    vim.g.bakaup_backup_dir = vim.fn.expand('~/.vim-temp/bakaup/')
  end,
}
