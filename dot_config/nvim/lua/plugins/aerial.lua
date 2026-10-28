-- Tree-sitter / LSP を使ってコードのシンボル構造をアウトライン表示し、素早くナビゲーションできる。
return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  cmd = {
    'AerialToggle',
    'AerialOpen',
    'AerialOpenAll',
    'AerialClose',
    'AerialCloseAll',
    'AerialNext',
    'AerialPrev',
    'AerialGo',
    'AerialInfo',
    'AerialNavToggle',
    'AerialNavOpen',
    'AerialNavClose',
  },
  keys = {
    { 'ga', '<cmd>AerialToggle!<CR>', mode = 'n', desc = 'Toggle aerial' },
  },
  opts = {},
}
