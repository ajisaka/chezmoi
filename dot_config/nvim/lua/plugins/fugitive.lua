-- Vim のネイティブ機能として Git コマンドを実行できる最強の Git ラッパープラグイン。
return {
  'tpope/vim-fugitive',
  cmd = {
    'Git',
    'Gtabedit',
  },
  keys = {
    { '<Leader>gc', ':tab Git ci -a<Space>', mode = { 'n' }, desc = 'Git commit' },
  },
}
