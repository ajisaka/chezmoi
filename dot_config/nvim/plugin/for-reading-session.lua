local function find_nox_buffer()
  -- Find `nox://...` buffer
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr):match('^nox://') then
      return bufnr
    end
  end
  vim.api.nvim_echo({ { 'No nox:// buffer found.', 'ErrorMsg' } }, true, {})
end

local function append_to_buffer(bufnr, text)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_echo({ { 'Buffer ' .. bufnr .. ' does not exist.', 'ErrorMsg' } }, true, {})
    return
  end

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local last_line = vim.api.nvim_buf_get_lines(bufnr, line_count - 1, line_count, false)[1] or ''
  local prefix = last_line:match('^%s*')
  vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, { prefix .. text })
end

local function find_page()
  local start_ln = vim.fn.line('.')
  for i = start_ln, math.max(start_ln - 100, 1), -1 do
    -- `@<page> ...` 形式のメタ行を上方向に探す
    local page = vim.fn.getline(i):match('^@%s*(%d+)')
    if page then
      return tonumber(page)
    end
  end
end

local function quote_text()
  local lines = {}
  for _, v in ipairs(vim.split(vim.fn.getreg('r'), '\n')) do
    if v ~= '' and not v:match('^@') then
      lines[#lines + 1] = v
    end
  end
  local selected_text = table.concat(lines, '')

  local page = find_page()

  local quote = '- `' .. selected_text .. '` P.' .. tostring(page)

  local nox_bufnr = find_nox_buffer()
  if not nox_bufnr then
    return
  end
  append_to_buffer(nox_bufnr, quote)

  local current_bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_set_current_buf(nox_bufnr)
  vim.cmd('silent write')
  vim.api.nvim_set_current_buf(current_bufnr)
end

local paste_action = function()
  if not vim.b.anekos_frs_in_target_buffer then
    return
  end
  vim.cmd('normal! "ry')
  quote_text()
end

local group = vim.api.nvim_create_augroup('NoxFiles', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = group,
  pattern = '/mnt/syno/data/ocr/*',
  callback = function(args)
    vim.b.anekos_frs_in_target_buffer = true

    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('x', ',,,', paste_action, opts)
    vim.keymap.set('x', 'p', paste_action, opts)
    vim.keymap.set('x', '<LeftRelease>', paste_action, opts)
  end,
})

