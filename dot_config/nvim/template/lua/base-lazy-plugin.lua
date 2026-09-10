return {
  'foo/bar',
  cond = false,
  event = 'VimEnter',
  filetypes = { 'lua' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<C-x><Space>', '<Plug>(eskk:toggle)', mode = { 'i', 'c' } },
  },
  cmd = {
    'BarCommand'
  },
  opts = {},
  config = function()
    require('bar').setup {
    }
  end,
}
