local sub_commands = {
  { 'fmt' },
  { 'init',    '--upgrade' },
  { 'output' },
  { 'plan' },
  { 'show' },
  { 'state',   'list' },
  { 'validate' },
  { 'apply' },
}

return {
  generator = function(_, callback)
    local valid = vim.bo.filetype == 'terraform' or vim.fn.glob('*.tf') ~= ''
    if not valid then
      callback {}
      return
    end

    callback(vim.tbl_map(function(args)
      return {
        name = 'terraform ' .. vim.fn.join(args, ' '),
        builder = function(_)
          return {
            cmd = { 'terraform' },
            args = args,
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
