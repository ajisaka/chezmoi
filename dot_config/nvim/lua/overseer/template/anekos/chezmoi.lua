local sub_commands = {
  { 'diff' },
  { 'apply' },
  { 'data' },
}

return {
  generator = function(_, callback)
    local valid = vim.fn.glob('.chezmoi*') ~= ''
    if not valid then
      callback {}
      return
    end

    callback(vim.tbl_map(function(args)
      local _args = {}
      vim.list_extend(_args, { '--color', 'false' })
      vim.list_extend(_args, args)
      return {
        name = 'chezmoi ' .. vim.fn.join(args, ' '),
        builder = function(_)
          return {
            cmd = { 'chezmoi' },
            args = _args,
            components = {
              'default',
            },
          }
        end,
      }
    end, sub_commands))
  end,
}
