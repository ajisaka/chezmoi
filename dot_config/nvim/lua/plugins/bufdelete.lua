-- ウィンドウレイアウトを崩さずにバッファを削除・ワイプする :Bdelete / :Bwipeout コマンドを提供する。
return {
  'famiu/bufdelete.nvim',
  -- keys = {
  --   { '<C-x><Space>', '<Plug>(eskk:toggle)', mode = { 'i', 'c' }, desc = 'Delete buffer' },
  -- },
  cmd = { 'Bdelete', 'Bwipeout' },
  -- opts = {},
  -- config = function() end,
}
