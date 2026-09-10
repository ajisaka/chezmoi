require('lazy').setup('plugins', {
  defaults = {
    lazy = true,
  },
  dev = {
    path = '~/forge/plugin/neovim',
    patterns = { 'anekos' },
    fallback = true,
  },
  change_detection = {
    -- https://github.com/folke/lazy.nvim/issues/32
    notify = false,
  },
  concurrency = vim.g.anekos_vim_private and 20 or 10,
})
