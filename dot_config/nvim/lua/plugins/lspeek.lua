-- LSP の定義・型定義をスタッカブルなフローティングウィンドウでプレビューする。現在位置を離れずに確認可能。
return {
  'r4ppz/lspeek.nvim',
  opts = {
    window = {
      width = 70,
      height = 15,
      border = 'single',
    },

    -- Limits the number of stack preview windows.
    stack_limit = 5,

    -- LSP can return multiple definitions (e.g., overloaded functions).
    -- false = open vim.ui.select to pick one (default).
    -- true  = skip the picker and jump to the first result.
    select_first = false,

    -- Preview window is read-only.
    -- To edit the file, open it in a split or a new buffer.
    keymaps = {
      close = 'q',
      split = 's',
      vsplit = 'v',
      enter = '<CR>',
      tab = 't',
    },
  },

  keys = {
    {
      '<Leader>lp',
      function()
        require('lspeek').peek_definition()
      end,
      desc = 'Peek Definition (lspeek)',
    },
    {
      '<Leader>lt',
      function()
        require('lspeek').peek_type_definition()
      end,
      desc = 'Peek Type Definition (lspeek)',
    },
  },
}
