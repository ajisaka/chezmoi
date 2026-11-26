local function run_liname_filter(extra_args)
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(win)

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local stdin = table.concat(lines, '\n')
  if not vim.endswith(stdin, '\n') then
    stdin = stdin .. '\n'
  end

  local cmd = { 'liname-filter' }
  for _, arg in ipairs(extra_args) do
    table.insert(cmd, arg)
  end

  local handle = require('fidget.progress').handle.create {
    title = 'LinameFilter',
    message = 'running...',
    lsp_client = { name = 'LinameFilter' },
  }

  -- Buffer stderr chunks and forward each line as a fidget progress update.
  local stderr_buf = ''
  local on_stderr = function(_err, data)
    if data == nil or data == '' then
      return
    end
    stderr_buf = stderr_buf .. data
    while true do
      local nl = stderr_buf:find('\n', 1, true)
      if not nl then
        break
      end
      local line = stderr_buf:sub(1, nl - 1)
      stderr_buf = stderr_buf:sub(nl + 1)
      if line ~= '' then
        vim.schedule(function()
          handle:report { message = line }
        end)
      end
    end
  end

  vim.system(cmd, { stdin = stdin, text = true, stderr = on_stderr }, function(result)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        handle:report { message = 'buffer no longer valid' }
        handle:finish()
        return
      end

      local stdout = result.stdout or ''
      local out_lines = vim.split(stdout, '\n', { plain = true })
      if out_lines[#out_lines] == '' then
        table.remove(out_lines)
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, out_lines)

      if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
        local line_count = vim.api.nvim_buf_line_count(buf)
        local new_row = math.min(cursor[1], math.max(1, line_count))
        local line_text = vim.api.nvim_buf_get_lines(buf, new_row - 1, new_row, false)[1] or ''
        local new_col = math.min(cursor[2], #line_text)
        vim.api.nvim_win_set_cursor(win, { new_row, new_col })
      end

      if result.code ~= 0 then
        handle:report { message = 'exited ' .. tostring(result.code) }
      end
      handle:finish()
    end)
  end)
end

vim.api.nvim_create_user_command('LinameFilter', function(opts)
  if opts.fargs[1] == '-f' then
    local path = table.concat(vim.list_slice(opts.fargs, 2), ' ')
    if path == '' then
      vim.notify('LinameFilter: -f requires a path', vim.log.levels.ERROR)
      return
    end
    run_liname_filter({ '-f', vim.fn.fnamemodify(path, ':p') })
  else
    if opts.args == '' then
      vim.notify('LinameFilter: instruction required', vim.log.levels.ERROR)
      return
    end
    run_liname_filter({ opts.args })
  end
end, {
  nargs = '+',
  complete = 'file',
  desc = 'Filter the current buffer through liname-filter. Pass an inline instruction, or "-f PATH" to read it from a file.',
})
