vim.api.nvim_create_user_command(
  'Plua',
  function(opts)
    print(vim.inspect(vim.fn.luaeval(opts.args)))
    print(1)
  end,
  {
    nargs = '*',
  }
)
