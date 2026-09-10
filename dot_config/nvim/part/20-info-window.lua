local utils = require('anekos.utils')

local function clean(s)
  local result = vim.fn.trim(s)
  if s == '' then
    return nil
  end
  return result
end

local function get_repository_path()
  return clean(vim.fn.system([[ git rev-parse --show-toplevel 2>/dev/null ]]))
end

local function get_branch()
  return clean(vim.fn.system([[ git rev-parse --abbrev-ref HEAD 2>/dev/null ]]))
end

local function generate()
  local result = {}

  local function append(label, text)
    table.insert(result, '  ' .. label .. ':')
    table.insert(result, '    ' .. text)
  end

  -- Global -- {{{
  table.insert(result, 'Global:')

  local colorscheme = vim.api.nvim_exec('colorscheme', true)
  append('Colorscheme', colorscheme)

  local _, achoo_state = pcall(require, 'achoo.state')
  if achoo_state and achoo_state.last_session then
    local _, achoo_session = pcall(require, 'achoo.session')
    append('Session', achoo_session.to_display(achoo_state.last_session))
  end

  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)
  append('Window', win_width .. ' x ' .. win_height)
  append('Current Directory', vim.fn.fnamemodify(vim.fn.getcwd(), ':~'))

  local repo = get_repository_path()
  if repo then
    append('Repository', vim.fn.fnamemodify(repo, ':~'))
  end

  local branch = get_branch()
  if branch then
    append('Branch', branch)
  end

  append('Font', vim.o.guifont)

  append('Interface', vim.g.anekos_vim_interface)

  append('Nyai', require('nyai.state').default_model().name)
  -- }}}

  -- Buffer {{{
  table.insert(result, 'Buffer:')

  local bufname = vim.api.nvim_buf_get_name(0)
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  local encoding = vim.api.nvim_buf_get_option(0, 'fileencoding')
  local line_count = vim.api.nvim_buf_line_count(0)
  local file_size = vim.fn.getfsize(bufname)

  append('Buffer Path', utils.relative_path(bufname, vim.fn.getcwd()))
  append('Filetype', filetype)
  append('Encoding', encoding)
  append('Line Count', tostring(line_count))
  append('File Size', tostring(file_size) .. ' bytes')
  -- }}}

  -- Cursor {{{
  table.insert(result, 'Cursor:')

  local cursor = vim.api.nvim_win_get_cursor(0)
  local char = vim.fn.matchstr(vim.fn.getline('.'), [[\%]] .. vim.fn.col('.') .. 'c.')
  local char_code = vim.fn.char2nr(char)

  append('Cursor Position', 'Line ' .. cursor[1] .. ', Column ' .. cursor[2])
  append('Char Code', string.format('U+%04X', char_code))
  -- }}}

  return result
end

-- Display functions {{{

local function notify(content)
  vim.notify(content, vim.log.levels.INFO, { title = 'Information' })
end

local function window(content)
  require('anekos.utils').popup_window { content = content }
end

-- }}}

-- Mapping {{{

local function information(display)
  return function()
    local content = generate()
    display(content)
  end
end

vim.keymap.set('n', '<C-g>', information(notify), { desc = 'Information' })
vim.keymap.set('n', 'g<C-g>', information(window), { desc = 'Information in window' })

-- }}}
