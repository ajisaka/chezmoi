vim.g.mapleader = ','

vim.keymap.set('n', 's', ',', { remap = true })
vim.keymap.set('x', 's', ',', { remap = true })

-- 小指を鍛えるエディタ風
vim.keymap.set('i', '<C-a>', '<C-o>^', {})
vim.keymap.set('i', '<C-e>', '<C-o>$', {})

-- コマンドモードの移動
vim.keymap.set('c', '<C-a>', '<Home>', {})
vim.keymap.set('c', '<C-d>', '<Del>', {})

-- 検索時に結果が中央に来るようにする
vim.keymap.set('n', 'n', 'nzzzv', {})
vim.keymap.set('n', 'N', 'Nzzzv', {})

-- for US KBD
vim.keymap.set({ 'n', 'x' }, ':', ';', {})
vim.keymap.set({ 'n', 'x' }, ';', ':', {})

-- JK ワイパー
vim.keymap.set('i', 'jk', '<Esc>', {})
vim.keymap.set('i', 'kj', '<Esc>', {})

-- 自然派
vim.keymap.set('n', 'Y', 'y$', {})

-- タブ
vim.keymap.set('n', 'gh', '1gt', { desc = 'Go to 1st tab' })

-- quickfix
vim.keymap.set('n', '<Leader>cp', '<Cmd>cprevious<CR>', { desc = 'Quickfix prev' })
vim.keymap.set('n', '<Leader>cn', '<Cmd>cnext<CR>', { desc = 'Quickfix next' })
vim.keymap.set('n', '<Leader>cf', '<Cmd>cfirst<CR>', { desc = 'Quickfix first' })
vim.keymap.set('n', '<Leader>cl', '<Cmd>clast<CR>', { desc = 'Quickfix last' })
vim.keymap.set('n', '<C-k>', '<Cmd>cprev<CR>', { desc = 'Quickfix prev' })
vim.keymap.set('n', '<C-l>', '<Cmd>cnext<CR>', { desc = 'Quickfix next' })
vim.keymap.set('n', '<C-b>', '<Cmd>lprev<CR>', { desc = 'Location prev' })
vim.keymap.set('n', '<C-f>', '<Cmd>lnext<CR>', { desc = 'Location next' })

-- 誤爆抑止
vim.keymap.set('n', 'S', '<nop>', {})

-- https://github.com/aramisgithub/dotfiles/blob/a6e7cab09cf414add888fa147a2849544cb67f09/files/vim/vimrc
vim.keymap.set('n', 'j', "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set('n', 'k', "v:count ? 'k' : 'gk'", { expr = true })

-- 挿入モードでの移動
vim.keymap.set('i', '<C-a>', '<Home>', {})
vim.keymap.set('i', '<C-e>', '<End>', {})
vim.keymap.set('i', '<C-f>', '<Right>', {})
vim.keymap.set('i', '<C-b>', '<Left>', {})

-- Omni Completion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', {})

-- コマンドラインで履歴たぐり
vim.keymap.set('c', '<C-k>', '<Up>', {})
vim.keymap.set('c', '<C-l>', '<Down>', {})

-- Ignore ex mode
vim.keymap.set('n', 'Q', '<Nop>', {})

-- Tab
vim.keymap.set('n', '<C-n>', '<Cmd>tabnext<CR>', {})
vim.keymap.set('n', '<C-p>', '<Cmd>tabprev<CR>', {})

-- Emacs ライクなキャンセル
vim.keymap.set({ 'c', 'i' }, '<C-g>', '<Esc>', {})

-- 改行
vim.keymap.set('n', '<CR>', 'A<CR><Esc>', {})

-- for vimeight
vim.keymap.set('v', '<C-a>', '<C-a>gv', {})
vim.keymap.set('v', '<C-x>', '<C-x>gv', {})

-- Repeat on visual mode
vim.keymap.set('v', '.', '<Cmd>normal .<CR>', { silent = true })

-- buffer
vim.keymap.set('n', '<Leader>x', '<Cmd>wincmd c<CR>', { desc = 'Close window' })

-- tab
vim.keymap.set('n', '<Leader>tn', '<Cmd>tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<Leader>te', ':<C-u>tabedit<Space><C-f>', { desc = 'Tab edit ...' })
vim.keymap.set('n', '<Leader>tx', '<Cmd>tabclose<CR>', { desc = 'Close tab' })

-- 保存 ﾎﾟﾗﾎﾟﾗﾎﾟﾗ
vim.keymap.set('n', '<Leader>w', '<Cmd>update<CR>', { desc = 'Update files' })
vim.keymap.set('n', '<Leader>W', '<Cmd>wall<CR>', { desc = 'Update all files' })

-- Checktime
vim.keymap.set('n', '<Leader><Leader>c', '<Cmd>checktime<CR>', { desc = 'Check time' })

-- Remove search highlight
vim.keymap.set('n', '<Leader><Leader>/', '<Cmd>nohlsearch<CR>', { desc = 'No search highlight' })

-- cd
vim.keymap.set('n', 'cd', ':<C-u>cd<Space>', { desc = 'cd ...' })

-- Insert date `2024-10-21`
vim.keymap.set('c', '<C-o>d', [[<C-r>=strftime('%Y-%m-%d')<CR>]], { remap = false })
vim.keymap.set('c', '<C-o>D', [[<C-r>=strftime('%Y/%m/%d')<CR>]], { remap = false })

-- 空のウィンドウを削除してサイズを揃える {{{
vim.keymap.set('n', '<Leader><Leader>b', function()
  for winnr = 1, vim.fn.winnr('$') do
    local bufnr = vim.fn.winbufnr(winnr)
    if bufnr >= 0 then
      if vim.fn.bufname(bufnr) == '' then
        vim.cmd('bdelete ' .. bufnr)
      elseif vim.fn.getbufvar(bufnr, '&filetype', '') == 'quickrun' then
        vim.cmd('bdelete! ' .. bufnr)
      end
    end
  end
  vim.cmd('wincmd =')
end, { silent = true, desc = 'Vanish empties' })

-- }}}

-- Toggle Bang {{{

vim.cmd([[
" http://twitter.com/tyru/status/13474491734

function! s:toggle_bang(cmdline)
  " :substituteみたいに引数とコマンドの間に
  " 空白がなくても呼ばれたりするものもあるので完璧ではない。
  " そもそも:substituteはbangとらないけど。
  let l:m = matchlist(a:cmdline, '^\(\s*\)\(\S\+\)\(.*\)')
  if empty(l:m) | return a:cmdline | endif
  let [l:ws, l:cmd, l:rest] = l:m[1:3]
  return l:ws . (l:cmd[strlen(l:cmd) - 1] ==# '!' ? l:cmd[:-2] : l:cmd . '!') . l:rest
endfunction

cnoremap <Plug>(cmdline-toggle-bang) <C-\>e <SID>toggle_bang(getcmdline())<CR>
cmap <C-x> <Plug>(cmdline-toggle-bang)
]])

-- }}}

-- 選択テキストを別ウィンドウに移動 {{{

local buffer = require('anekos.buffer')
for _, direction in ipairs { 'h', 'j', 'k', 'l' } do
  vim.keymap.set('v', '<Leader>g' .. direction, function()
    local current_win = vim.api.nvim_get_current_win()
    buffer.cut_selected_text_async(function(selected_text)
      vim.cmd.wincmd(direction)
      buffer.append_text_to_buffer_end(selected_text)
      vim.api.nvim_set_current_win(current_win)
    end)
  end, { silent = true, desc = 'Move selected text' })
end

vim.keymap.set('v', '<Leader>gg', function()
  buffer.cut_selected_text_async(function(selected_text)
    vim.notify(vim.fn.split(vim.inspect(selected_text), '\n'), vim.log.levels.ERROR)
  end)
end, { silent = true, desc = 'Move selected text' })

-- }}}

-- No Zen {{{

local ZenToHan = {
  { '　', '<Space>' },
  { '（', '(' },
  { '）', ')' },
  { '｛', '{' },
  { '｝', '}' },
  { '；', ';' },
  { '：', ':' },
  { '｜', '<Bar>' },
  { '＜', '<' },
  { '＞', '>' },
  { '＊', '*' },
  { '＠', '@' },
  { '－', '-' },
  -- { 'ー', '-' },
  { '％', '%' },
  { '＃', '#' },
  { '”', '"' },
  { '’', "'" },
  { '＋', '+' },
  { '０', '0' },
  { '１', '1' },
  { '２', '2' },
  { '３', '3' },
  { '４', '4' },
  { '５', '5' },
  { '６', '6' },
  { '７', '7' },
  { '８', '8' },
  { '９', '9' },
  { '～', '~' },
  { '？', '?' },
}

for _, v in ipairs(ZenToHan) do
  vim.keymap.set('i', v[1], v[2], {})
end

-- }}}

-- Terminal mode {{{
vim.keymap.set('t', '<C-\\>w', '<C-\\><C-n><C-w>w', { desc = 'Escape from terminal' })
vim.keymap.set('t', '<C-x><C-v>', '<C-\\><C-n>"+pa', { desc = 'Paste from clipboard' })
-- }}}
