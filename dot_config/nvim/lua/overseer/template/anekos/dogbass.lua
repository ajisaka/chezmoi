local sub_commands = {
  { 'pull' },
  { 'push' },
  { 'push', '--notify' },
  { 'push', '--no-notify' },
}

local function has_pattern_in_buffer(pattern)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    if line:match(pattern) then
      return true
    end
  end
  return false
end

local function is_valid_buffer()
  if vim.bo.filetype ~= 'markdown' then
    return false
  end

  if not has_pattern_in_buffer('^---') then
    return false
  end

  if not has_pattern_in_buffer('^title: ') then
    return false
  end

  return true
end

return {
  generator = function(_, callback)
    if not is_valid_buffer() then
      callback {}
      return
    end

    callback(vim.tbl_map(function(args)
      local _args = vim.deepcopy(args)
      local name = 'dogbass ' .. vim.fn.join(_args, ' ')
      local buffer_path = vim.api.nvim_buf_get_name(0)
      table.insert(_args, buffer_path)
      return {
        name = name,
        builder = function(_)
          return {
            cmd = { 'dogbass' },
            args = _args,
            components = {
              'notify-output',
              'default',
            },
          }
        end,
      }
    end, sub_commands))
  end,
}
