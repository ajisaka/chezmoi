-- 最後に選択したカラースキームをセッション間で記憶・復元するプラグイン。GUI/CUI で別々に保存する。
local infix = (vim.g.anekos_vim_gui == 1) and 'gui' or 'cui'
local filepath = vim.fn.stdpath('data') .. '/remember-colorscheme.' .. infix .. '.vim'

return {
  'anekos/remember-colorscheme.nvim',

  cond = require('anekos.priority').colors.use == 'remember',
  priority = require('anekos.priority').colors.remember_colorscheme,

  lazy = false,

  opts = {
    filepath = filepath,
  },
}
