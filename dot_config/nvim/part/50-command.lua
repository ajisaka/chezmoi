vim.api.nvim_create_user_command('Plua', function(opts)
  print(vim.inspect(vim.fn.luaeval(opts.args)))
end, {
  nargs = '*',
})

vim.api.nvim_create_user_command('Rename', function(opts)
  vim.cmd {
    cmd = 'save',
    args = { opts.args },
  }
  vim.fn.delete(vim.fn.expand('#'))
  vim.cmd {
    cmd = 'bdelete',
    args = { vim.fn.bufnr('#') },
  }
end, {
  nargs = 1,
  complete = 'file',
})

vim.api.nvim_create_user_command('SSF', function()
  vim.cmd('syntax sync fromstart')
end, {
  bar = true,
})

vim.api.nvim_create_user_command('RemoveTrailingSpaces', function()
  vim.cmd([[ %s/[  	]\+$//c ]])
end, {
  bar = true,
})

vim.api.nvim_create_user_command('Cleanup', function()
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/[  \r]\+$// ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/[　]/ /g ]])
  -- 全角括弧 → 半角括弧
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/（/(/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/）/)/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/｛/{/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/｝/}/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/［/[/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/］/]/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/【/[/g ]])
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[ %s/】/]/g ]])
end, {
  bar = true,
})

vim.api.nvim_create_user_command('Chmod', function(opts)
  local perm = opts.args[0] or '+x'
  vim.fn.system('touch ' .. vim.fn.shellescape(vim.fn.expand('%')))
  vim.fn.system('chmod ' .. perm .. ' ' .. vim.fn.shellescape(vim.fn.expand('%')))
end, {
  bar = true,
  nargs = '*',
})

vim.api.nvim_create_user_command('Literalize', function(opts)
  local lines = vim.fn.getline(opts.line1, opts.line2)
  assert(type(lines) == 'table')
  for i, line in ipairs(lines) do
    vim.fn.setline(opts.line1 + i - 1, '[[' .. line .. ']],')
  end
end, {
  nargs = '*',
  range = '%',
})

vim.api.nvim_create_user_command('MFC', function(opts)
  local result = vim.fn.system('mfc ' .. vim.fn.shellescape(opts.args) .. ' println')
  require('anekos.buffer').insert_text(result)
end, {
  nargs = '*',
})

vim.api.nvim_create_user_command('DeleteHiddenBuffers', function()
  local count = 0
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if buf.hidden == 1 or buf.loaded == 0 then
      local ok = pcall(vim.cmd.bwipeout, buf.bufnr)
      if ok then
        count = count + 1
      else
        print('Failed to delete buffer: ' .. buf.bufnr)
      end
    end
  end
  print(tostring(count) .. ' buffers are deleted.')
end, {
  nargs = 0,
})

vim.api.nvim_create_user_command('SnippetAdd', function()
  vim.cmd.tabedit('~/.config/nvim/snippet/snipmate/' .. vim.o.filetype .. '.snippets')
  -- vim.fn.appendbufline(0, vim.fn.line('$'), 'snippet ')
  -- vim.cmd.startinsert()
end, {
  nargs = '*',
})

vim.api.nvim_create_user_command('Mkcd', function(opts)
  local path = vim.fn.fnamemodify(opts.args, ':p')
  vim.fn.system('mkdir -p ' .. vim.fn.shellescape(path))
  vim.cmd.cd(path)
end, {
  nargs = '*',
  complete = 'dir',
})

vim.api.nvim_create_user_command('LLMFilter', function(opts)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local buffer_content = table.concat(lines, '\n')

  local prompt = opts.args .. '\n\n' .. buffer_content

  local handle = vim.fn.jobstart({ 'llm', '-s', 'Do not include any unnecessary explanations or comments' }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and #data > 0 then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
      end
    end,
    on_stderr = function(_, err)
      if err and 0 < #err and 0 < #err[1] then
        if string.find(err[1], 'Cannot read termcap database') then
          return
        end
        vim.notify(err, vim.log.levels.ERROR)
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Done')
      else
        vim.api.nvim_echo({ { 'llm command failed with exit code ' .. code } }, true, { err = true })
      end
    end,
    stdin = 'pipe',
  })

  if handle > 0 then
    vim.fn.chansend(handle, prompt)
    vim.fn.chanclose(handle, 'stdin')
  else
    vim.api.nvim_echo({ { 'Failed to start llm command' } }, true, { err = true })
  end
end, {
  nargs = 1,
  desc = 'Run LLM command with user input and current buffer content',
})

vim.api.nvim_create_user_command('SendToKindleOnWaydroid', function(opts)
  vim.cmd('normal! gv"+y')

  vim.fn.setreg('*', vim.fn.getreg('+'))

  vim.defer_fn(function()
    vim.fn.system('adb shell input tap 1460 66')
    vim.defer_fn(function()
      vim.fn.system('adb shell input keyevent 279')
      vim.defer_fn(function()
        vim.fn.system('adb shell input keyevent KEYCODE_ENTER')
      end, 300)
    end, 300)
  end, 200)
end, {
  nargs = 0,
  desc = 'Send clipboard to Kindle on Waydroid',
  range = true,
})
