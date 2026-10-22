-- Tree-sitter を使ってコードブロック（配列・オブジェクト等）を1行/複数行に分割・結合するプラグイン。
return {
  'Wansmer/treesj',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<Leader>mm', '<Cmd>TSJToggle<CR>', mode = { 'n' }, desc = 'TS Join/Split' },
    { '<Leader>ms', '<Cmd>TSJSplit<CR>', mode = { 'n' }, desc = 'TS Split' },
    { '<Leader>mj', '<Cmd>TSJJoin<CR>', mode = { 'n' }, desc = 'TS Join' },
  },
  config = function()
    require('treesj').setup {}
  end,
  cmd = { 'TSJToggle', 'TSJJoin', 'TSJSplit' },
}
