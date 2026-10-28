-- キーでサブモードに入り、連続操作を単一キーで繰り返せるカスタムサブモードを作成できる。
return {
  'kana/vim-submode',
  keys = {
    { '<Leader>sw', mode = 'n' },
    { '<Leader>ss', mode = 'n' },
    { '<Leader>sf', mode = 'n' },
    { '<Leader>sj', mode = 'n' },
  },
  config = function()
    vim.fn['submode#current']()

    vim.g.submode_timeoutlen = 2000

    local enter_with = vim.fn['submode#enter_with']
    local leave_with = vim.fn['submode#leave_with']
    local map = vim.fn['submode#map']

    -- Change current window size.
    enter_with('winsize', 'n', '', ',sw', '<Nop>')
    leave_with('winsize', 'n', '', '<Esc>')
    map('winsize', 'n', '', 'j', '<C-w>-:redraw<CR>')
    map('winsize', 'n', '', 'k', '<C-w>+:redraw<CR>')
    map('winsize', 'n', '', 'h', '<C-w><:redraw<CR>')
    map('winsize', 'n', '', 'l', '<C-w>>:redraw<CR>')
    map('winsize', 'n', '', '=', '<C-w>=:redraw<CR>')

    -- -- Change font size size.
    enter_with('fontsize', 'n', '', ',sf', '<Nop>')
    leave_with('fontsize', 'n', '', '<Esc>')
    map('fontsize', 'n', '', 'j', '<Cmd>FontSize +1<CR>')
    map('fontsize', 'n', '', 'k', '<Cmd>FontSize -1<CR>')

    -- -- Jump
    enter_with('jumplist', 'n', '', ',sj', '<Nop>')
    leave_with('jumplist', 'n', '', '<Esc>')
    map('jumplist', 'n', '', 'j', '<C-i>')
    map('jumplist', 'n', '', 'k', '<C-o>')
  end,
}
