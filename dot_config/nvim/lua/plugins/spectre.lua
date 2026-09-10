-- ripgrep と sed を使ってプロジェクト全体でテキストを検索・置換するパネル型プラグイン。変更をプレビューしてから適用できる。
return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = {
    'Spectre',
  },
  keys = {
    { '<Leader>jA', '<Cmd>Spectre<CR>', mode = { 'n' }, desc = 'Spectre find' },
  },
  opts = {},
  config = function()
    require('spectre').setup {}
  end,
}
