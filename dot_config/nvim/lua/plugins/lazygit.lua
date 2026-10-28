-- lazygit をフローティングウィンドウで起動し、Neovim を離れずに Git 操作を行える。
return {
  'kdheepak/lazygit.nvim',
  cmd = { 'LazyGit', 'LazyGitConfig' },
  keys = {
    { '<Leader>gg', '<Cmd>LazyGit<CR>', mode = 'n', desc = 'Lazy git' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension('lazygit')
  end,
}
