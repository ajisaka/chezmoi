-- tree-sitter を使って関数引数・リスト要素などのノードをインタラクティブに選択して入れ替える。
return {
  'mizlan/iswap.nvim',
  keys = {
    { 'SS', '<Cmd>ISwapWith<CR>', mode = { 'n' }, desc = 'ISwap' },
  },
  cmd = {
    'ISwap',
    'ISwapWith',
    'ISwapNode',
    'ISwapNodeWith',
    'IMove',
    'IMoveWith',
    'IMoveNode',
    'IMoveNodeWith',
  },
  opts = {},
  config = function() end,
}
