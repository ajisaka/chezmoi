-- クリップボードの変更を監視し、新たにコピーされたテキストをバッファへ自動追記する。
return {
  'anekos/clipboard-quoter.nvim',
  dev = true,
  cmd = {
    'ClipboardQuoterToggle'
  },
  opts = {},
  config = function()
    -- require('clipboard-quoter').setup {
    -- }
  end,
}
