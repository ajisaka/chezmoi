-- 正規表現や関数を使ってカスタムテキストオブジェクトを簡単に定義するためのフレームワーク。
return {
  'kana/vim-textobj-user',
  event = 'CursorMoved',
  dependencies = {
    'kana/vim-textobj-entire',
    'kana/vim-textobj-fold',
    'kana/vim-textobj-indent',
    'osyo-manga/vim-textobj-multiblock',
    'kana/vim-textobj-syntax',
    'mattn/vim-textobj-url',
    'anekos/vim-textobj-markdown-list',
  },
}
