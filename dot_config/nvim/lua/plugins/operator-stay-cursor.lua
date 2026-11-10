-- オペレータ実行後にカーソルを元の位置に留めるラッパーを提供する。
return {
  -- " オペレータ実行時にカーソルを移動しないようにする
  'osyo-manga/vim-operator-stay-cursor',
  keys = {
    { 'gu', '<Plug>(operator-stay-cursor-gu)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Stay cursor' },
    { 'gU', '<Plug>(operator-stay-cursor-gU)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Stay cursor' },
  },
  dependencies = { 'kana/vim-operator-user' },
}
