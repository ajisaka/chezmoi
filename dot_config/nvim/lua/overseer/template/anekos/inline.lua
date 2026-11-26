local prefix = 'overseer:'

local function get_command_lines()
  local function _get_command_lines()
    local result = {}
    local comment_string = vim.o.commentstring
    local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local left, right = comment_string:match('(.+)%%s(.*)')
    -- print('left: ', left, 'right: ', vim.inspect(right))

    for _, line in ipairs(buffer_lines) do
      local left_at = string.find(line, left, 1, true)
      local right_at = string.find(line, right, 1, true)

      if left_at ~= nil and right == '' then
        right_at = #line + 1
      end

      if left_at ~= nil and right_at ~= nil and left_at < right_at then
        -- print('line: ', line, 'left_at: ', left_at, 'right_at: ', right_at)
        local inner = vim.trim(string.sub(line, left_at + #left, right_at - 1))
        -- print('inner: ' .. inner .. '>>')
        if vim.startswith(inner, prefix) then
          local command = vim.trim(inner:sub(#prefix + 1))
          table.insert(result, command)
        end
      end
    end

    return result
  end

  local ok, result = pcall(_get_command_lines)
  if ok then
    return result
  end
  return {}
end

local function expand(cl)
  cl = string.gsub(cl, '%%q', vim.fn.shellescape(vim.fn.bufname()))
  cl = string.gsub(cl, '%%s', vim.fn.bufname())
  return cl
end

return {
  generator = function(_, callback)
    callback(vim.tbl_map(function(command_line)
      local expanded = expand(command_line)

      return {
        name = 'Run ' .. command_line,
        builder = function(_)
          return {
            cmd = { 'bash' },
            args = {
              '-c',
              expanded,
            },
            components = {
              'notify-output',
              'default',
            },
          }
        end,
      }
    end, get_command_lines()))
  end,
}
