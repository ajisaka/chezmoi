-- Base16 パレット（16色）から Neovim のカラースキームを高速生成する。主要プラグインのハイライトグループにも対応。
return {
  'echasnovski/mini.base16',

  cond = require('anekos.priority').colors.use == 'base16',
  priority = require('anekos.priority').colors.base16,

  version = '*',
  lazy = false,
  config = function()
    local palette = {
        base00 = '#002635',
        base01 = '#00384d',
        base02 = '#517f8d',
        base03 = '#6c8b91',
        base04 = '#869696',
        base05 = '#a1a19a',
        base06 = '#e6e6dc',
        base07 = '#fafaf8',
        base08 = '#ff5a67',
        base09 = '#f08e48',
        base0A = '#ffcc1b',
        base0B = '#7fc06e',
        base0C = '#5dd7b9',
        base0D = '#14747e',
        base0E = '#9a70a4',
        base0F = '#c43060',
      }

    require('mini.base16').setup {
      -- Table with names from `base00` to `base0F` and values being strings of
      -- HEX colors with format "#RRGGBB". NOTE: this should be explicitly
      -- supplied in `setup()`.
      palette = palette,

      -- Whether to support cterm colors. Can be boolean, `nil` (same as
      -- `false`), or table with cterm colors. See `setup()` documentation for
      -- more information.
      use_cterm = nil,

      -- Plugin integrations. Use `default = false` to disable all integrations.
      -- Also can be set per plugin (see |MiniBase16.config|).
      plugins = { default = true },
    }
  end,
}