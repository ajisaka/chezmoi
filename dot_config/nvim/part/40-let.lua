-- Default plugins {{{

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- vim.g.loaded_2html_plugin       = 1
-- vim.g.loaded_netrw              = 1
-- vim.g.loaded_netrwFileHandlers  = 1
-- vim.g.loaded_netrwPlugin        = 1
-- vim.g.loaded_netrwSettings      = 1
-- vim.g.loaded_rrhelper           = 1

if not vim.fn.has('gui_running') then
  vim.g.loaded_matchparen = 1
end

-- }}}

-- lisp
vim.g.lisp_instring = 0
vim.g.lisp_rainbow = 1

-- misc
vim.g.anekos_vim_work_for = 'me'
