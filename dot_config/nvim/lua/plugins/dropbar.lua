-- IDE スタイルのパンくずリスト (winbar) を表示し、シンボルをドロップダウンメニューでインタラクティブに辿れる。
return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  event = { 'VeryLazy' },
  config = function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<Leader>pp', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '<Leader>ph', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '<Leader>pl', dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
