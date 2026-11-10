-- アニメーション付きのポップアップ通知ウィンドウを提供する。vim.notify を置き換えてログレベル別に表示スタイルを設定できる。
return {
  'rcarriga/nvim-notify',
  event = { 'VeryLazy' },
  init = function()
    vim.api.nvim_set_option_value('termguicolors', true, { scope = 'global' })
  end,
  config = function()
    require('notify').setup {
      top_down = false,
      stages = 'fade_in_slide_out',
      level = 2, -- Minimum log level to display. See vim.log.levels.
    }
    vim.notify = require('notify')

    require('telescope').load_extension('notify')
  end,
}
