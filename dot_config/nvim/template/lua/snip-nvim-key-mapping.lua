vim.keymap.set(
  { 'n' },
  '<Leader>lF',
  function()
    vim.lsp.buf.format()
    print(1)
  end,
  { remap = true, silent = true }
)
