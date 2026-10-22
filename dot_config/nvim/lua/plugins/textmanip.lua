-- 選択テキストを上下左右に移動・複製するプラグイン。インサートモードとリプレースモードの両方で動作する。
return {
  't9md/vim-textmanip',
  keys = {
    { '<C-j>', '<Plug>(textmanip-move-down)', remap = false, mode = 'x',  },
    { '<C-k>', '<Plug>(textmanip-move-up)', remap = false, mode = 'x' },
    { '<C-h>', '<Plug>(textmanip-move-left)', remap = false, mode = 'x' },
    { '<C-l>', '<Plug>(textmanip-move-right)', remap = false, mode = 'x' },
    { '<Leader>j', '<Plug>(textmanip-duplicate-down)', remap = false, mode = 'x' },
    { '<Leader>k', '<Plug>(textmanip-duplicate-up)', remap = false, mode = 'x' },
  },
  init = function()
    vim.g.textmanip_enable_mappings = 0
  end,
}
