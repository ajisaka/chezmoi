local function get_scripts()
  return vim.fn.globpath('.', 'overseer.*.sh', false, true)
end

local function extract_name(s)
  local match = s:match("^./overseer%.(.-)%.sh$")
  return match
end

return {
  generator = function(_, callback)
    callback(vim.tbl_map(function(script)
      local name = extract_name(script)
      return {
        name = 'Run `' .. name .. '`',
        builder = function(_)
          return {
            cmd = { 'bash' },
            args = {
              script,
            },
            components = {
              'notify-output',
              'default',
            },
          }
        end,
      }
    end, get_scripts()))
  end,
  condition = {
    callback = function(_)
      return 0 < #get_scripts()
    end,
  },
}
