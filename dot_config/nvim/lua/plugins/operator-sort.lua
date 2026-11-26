-- 選択テキストをアルファベット順・数値順でソートするオペレータプラグイン。逆順ソートにも対応。
return {
  'emonkak/vim-operator-sort',
  keys = {
    { '<Leader>s', '<Plug>(operator-sort)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Sort operator' },
  },
  dependencies = { 'kana/vim-operator-user' },
}
