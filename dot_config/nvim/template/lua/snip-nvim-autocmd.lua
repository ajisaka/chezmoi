vim.api.nvim_create_autocmd(
  { 'VimEnter', 'CmdlineEnter' },
  {
    pattern = {"*.c", "*.h"},
    callback = function ()
      print(1)
      print(2)
    end,
    -- group
  }
)
