-- Tailwind CSS クラスの補完・カラープレビュー・クラスのソートと整理を提供する。
return {
  'luckasRanarison/tailwind-tools.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  filetype = { 'html', 'typescript', 'typescriptreact', 'elm' },
  opts = {},
  cond = false,
  config = function()
    require('tailwind-tools').setup {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = 'inline', -- "inline" | "foreground" | "background"
        inline_symbol = '󰝤 ', -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = true, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = '󱏿', -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = '#38BDF8',
        },
      },
      -- see the extension section to learn more
      extension = {
        queries = {}, -- a list of filetypes having custom `class` queries
        patterns = { -- a map of filetypes to Lua pattern lists
          -- exmaple:
          -- rust = { "class=[\"']([^\"']+)[\"']" },
          -- javascript = { "clsx%(([^)]+)%)" },
        },
      },
    }
  end,
}
