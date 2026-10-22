local FILE_PATH = '/tmp/xmosh/book-manager-chrysoberyl-status.json'
local INTERVAL_MS = 1000

local text_file_prefix = '/mnt/syno/data/ocr/text/'
local timer = nil
local last_content = nil

local function to_string(value)
  if type(value) == 'string' then
    return value
  elseif type(value) == 'number' or type(value) == 'boolean' then
    return tostring(value)
  else
    return vim.fn.json_encode(value)
  end
end

local function find_text_buffers()
  local result = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if vim.startswith(name, text_file_prefix) then
        table.insert(result, buf)
      end
    end
  end
  return result
end

local function read_status_content()
  if vim.fn.filereadable(FILE_PATH) == 0 then
    return nil
  end

  local ok_read, lines = pcall(vim.fn.readfile, FILE_PATH)
  if not ok_read then
    return nil
  end
  local content = table.concat(lines, '\n')
  if content == '' then
    return nil
  end
  return content
end

local function parse_status(content)
  local ok_decode, parsed = pcall(vim.json.decode, content)
  if not ok_decode or type(parsed) ~= 'table' then
    return nil
  end
  return parsed
end

local function target_page(status)
  local l, r = status.left_page, status.right_page
  if type(l) == 'number' and type(r) == 'number' then
    return math.min(l, r)
  end
  if type(l) == 'number' then
    return l
  end
  if type(r) == 'number' then
    return r
  end
  return nil
end

local function goto_marker(forward)
  local flags = forward and 'W' or 'bW'
  if vim.fn.search([[^@\d\+\( (\d\+)\)\?$]], flags) > 0 then
    vim.api.nvim_set_option_value('scrolloff', 0, { win = 0 })
    vim.cmd('normal! zt')
  end
end

local function setup_text_buffer_mappings(buf)
  local opts = { buffer = buf, silent = true }
  vim.keymap.set('n', '<C-d>', function()
    goto_marker(true)
  end, opts)
  vim.keymap.set('n', '<C-u>', function()
    goto_marker(false)
  end, opts)
end

local function find_marker_line(buf, page)
  local marker = '@' .. tostring(page)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for i, line in ipairs(lines) do
    if vim.startswith(line, marker) then
      return i
    end
  end
  return nil
end

local function scroll_to_page(page)
  for _, buf in ipairs(find_text_buffers()) do
    local wins = vim.fn.win_findbuf(buf)
    if #wins > 0 then
      local lnum = find_marker_line(buf, page)
      if lnum then
        for _, win in ipairs(wins) do
          vim.api.nvim_set_option_value('scrolloff', 0, { win = win })
          vim.api.nvim_win_set_cursor(win, { lnum, 0 })
          vim.api.nvim_win_call(win, function()
            vim.cmd('normal! zt')
          end)
        end
      end
    end
  end
end

local function apply_status(status)
  if status.left_page ~= nil then
    vim.fn.setreg('h', 'P.' .. to_string(status.left_page))
  end
  if status.right_page ~= nil then
    vim.fn.setreg('l', 'P.' .. to_string(status.right_page))
  end
  local page = target_page(status)
  if page ~= nil then
    scroll_to_page(page)
  end
end

local function read_and_set()
  local content = read_status_content()
  if not content or content == last_content then
    return
  end
  local status = parse_status(content)
  if not status then
    return
  end
  last_content = content
  apply_status(status)
end

local function start()
  if timer then
    vim.notify('BookManager: already running', vim.log.levels.WARN)
    return
  end
  local new_timer = vim.uv.new_timer()
  if not new_timer then
    vim.notify('BookManager: failed to create timer', vim.log.levels.ERROR)
    return
  end
  timer = new_timer
  timer:start(0, INTERVAL_MS, vim.schedule_wrap(read_and_set))
  vim.notify('BookManager: started (' .. FILE_PATH .. ')')
end

local function stop()
  if not timer then
    vim.notify('BookManager: not running', vim.log.levels.WARN)
    return
  end
  timer:stop()
  timer:close()
  timer = nil
  last_content = nil
  vim.notify('BookManager: stopped')
end

vim.api.nvim_create_user_command('BookManagerStart', start, {})
vim.api.nvim_create_user_command('BookManagerStop', stop, {})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = text_file_prefix .. '*',
  callback = function(args)
    setup_text_buffer_mappings(args.buf)
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    if timer then
      timer:stop()
      timer:close()
      timer = nil
    end
  end,
})
