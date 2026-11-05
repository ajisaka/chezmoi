-- Vim 上で動作する SKK 日本語入力メソッド。インサート・コマンドモードでかな漢字変換を提供する。
return {
  'vim-skk/eskk.vim',
  cond = false,
  keys = {
    { '<C-x><Space>', '<Plug>(eskk:toggle)', mode = { 'i', 'c' }, desc = 'SKK' },
  },
  config = function()
    vim.g['eskk#directory'] = '~/.eskk'
    vim.g['eskk#dictionary'] = { path = '~/.skk/SKK-JISYO.M', sorted = 1, encoding = 'euc-jp' }
    -- vim.g['eskk#dictionary'] = { path = '~/.eskk/user.dict', sorted = 1, encoding = 'euc-jp' }
    vim.g['eskk#large_dictionary'] = { path = '~/.config/nvim/SKK-JISYO.L.txt', sorted = 1, encoding = 'euc-jp' }
  end,
}
