-- キーワード・カーソル下の単語・タグをオンザフライで複数色同時ハイライト表示する。
return {
  't9md/vim-quickhl',
  keys = {
    { '<Leader>hh', '<Plug>(quickhl-manual-this)', mode = { 'n', 'v' }, remap = true, desc = 'HL toggle' },
    { '<Leader>hr', '<Plug>(quickhl-manual-reset)', mode = { 'n', 'v' }, remap = true, desc = 'HL reset' },
    { '<Leader>hd', '<Cmd>QuickhlManualDelete<CR>', desc = 'HL delte' },
    { '<Leader>ha', ':<C-u>QuickhlManualAdd<Space><C-f>', desc = 'HL add ...' },
  },
  config = function()
    -- " 1 だと重いョ
    vim.g.quickhl_tag_enable_at_startup = 0
    vim.g.quickhl_manual_keywords = { 'IMPLEMENTME' }
  end,
}
