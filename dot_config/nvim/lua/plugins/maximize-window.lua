-- 現在のウィンドウを最大化し、元のレイアウトに復元するトグル機能を提供するプラグイン。
return {
  'anekos/maximize-window.nvim',
  keys = {
    { '<C-w>m', '<Plug>(maximize-window)', mode = { 'n' }, desc = 'Maximize window' },
  },
}
