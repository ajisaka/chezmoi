-- 高速ターミナルファイルマネージャー yazi をフローティングウィンドウで開く。選択ファイルをバッファ・分割・タブで開ける。
return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = { 'folke/snacks.nvim', lazy = true },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '<leader>yf',
      mode = { 'n' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      -- Open in the current working directory
      '<leader>yy',
      mode = { 'n' },
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
    -- {
    --   '<c-up>',
    --   '<cmd>Yazi toggle<cr>',
    --   desc = 'Resume the last yazi session',
    -- },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
