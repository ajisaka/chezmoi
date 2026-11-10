-- コマンドラインで短縮入力した曖昧なコマンドを自動補完し、E464（ambiguous command）エラーを解消する。
return {
  'thinca/vim-ambicmd',
  keys = {
    { '<CR>', 'ambicmd#expand("<CR>")', mode = 'c', expr = true, desc = 'Ambicmd' },
    { '<Space>', 'ambicmd#expand("<Space>")', mode = 'c', expr = true, desc = 'Ambicmd' },
  },
}
