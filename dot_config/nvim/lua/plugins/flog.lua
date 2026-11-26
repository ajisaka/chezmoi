-- Git コミット履歴をグラフ形式で視覚的に表示し、fugitive と連携してブランチ操作を行う。
return {
  'rbong/vim-flog',
  cmd = { 'Flog', 'Flogsplit', 'Floggit' },
  dependencies = {
    'tpope/vim-fugitive',
  },
}
