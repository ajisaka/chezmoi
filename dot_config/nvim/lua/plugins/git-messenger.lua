-- カーソル行の Git コミット履歴・メッセージをポップアップで表示し、過去の diff も閲覧できる。
return {
  'rhysd/git-messenger.vim',
  keys = {
    { '<Leader>gm', '<Plug>(git-messenger)', mode = { 'n' }, desc = 'Git messenger' },
  },
  cmd = {
    'GitMessenger',
  },
  config = function()
    vim.g.git_messenger_include_diff = 'current'
    vim.g.git_messenger_close_on_cursor_moved = true
    vim.g.git_messenger_always_into_popup = true
  end,
}
