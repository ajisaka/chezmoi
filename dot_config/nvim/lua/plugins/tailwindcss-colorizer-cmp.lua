-- nvim-cmp の補完候補に Tailwind CSS のカラーヒント（色見本）を VS Code スタイルで表示する。
return {
  'roobert/tailwindcss-colorizer-cmp.nvim',
  ft = {
    'typescriptreact',
  },
  config = function()
    require('tailwindcss-colorizer-cmp').setup {
      color_square_width = 2,
    }
    require('cmp').config.formatting = {
      format = require('tailwindcss-colorizer-cmp').formatter,
    }
  end,
}
