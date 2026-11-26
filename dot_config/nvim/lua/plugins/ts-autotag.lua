-- Tree-sitter を使って HTML タグを自動で閉じ、タグ名変更時にペアも自動で更新する。
return {
  'windwp/nvim-ts-autotag',
  filetypes = { 'typescriptreact', 'html', 'xml' },
  opts = {},
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ['html'] = {
          enable_close = false,
        },
      },
    }
  end,
}
