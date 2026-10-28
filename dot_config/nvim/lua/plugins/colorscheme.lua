-- 複数のカラースキームをまとめて管理するファイル。base16 以外の場合に各カラースキームを lazy ロードする。
-- https://dotfyle.com/neovim/colorscheme/trending

if require('anekos.priority').colors.use == 'base16' then
  return {}
end

local colors = {
  -- Classic (?) Color Schemes {{{
  {
    'andreasvc/vim-256noir',
  },
  {
    'ab-dx/ares.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    'kuuote/elly.vim',
    -- 'elly.vim is a nostalgic and brown-based Vim color theme.',
  },
  -- }}}
  -- Tree-Sitter Supported Color Schemes {{{
  -- https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#tree-sitter-supported-colorscheme
  {
    'rose-pine/neovim',
  },
  {
    'xero/miasma.nvim',
    -- supports treesitter, gitsigns, lazy, which-key, telescope, lsp diagnostics, and more.
  },
  {
    'EdenEast/nightfox.nvim',
    -- A soft dark, fully customizable Neovim theme, with support for lsp, treesitter and a variety of plugins.
  },
  {
    'folke/tokyonight.nvim',
    -- A clean, dark and light Neovim theme written in Lua, with support for LSP, Tree-sitter and lots of plugins.
  },
  {
    'catppuccin/nvim',
    -- Warm mid-tone dark theme to show off your vibrant self! with support for native LSP, Tree-sitter, and more 🍨!
  },
  {
    'rebelot/kanagawa.nvim',
    -- Neovim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  },
  {
    'neanias/everforest-nvim',
    -- A Lua port of the Everforest colour scheme.
  },
  {
    'Mofiqul/vscode.nvim',
    -- A Lua port of vim-code-dark colorscheme with vscode light and dark theme.
  },
  {
    '0xstepit/flow.nvim',
    -- fugitive, gitsign, nvim-cmp, lsp-kind, nvim-dap, lazy, telescope, treesitter, trouble, todo-comments, which-key, diagnostic, lsp, markdown,
  },
  {
    'mrjones2014/lighthaus.nvim',
  },
  {
    'rmehri01/onenord.nvim',
  },
  {
    'olimorris/onedarkpro.nvim',
  },
  {
    'dgox16/oldworld.nvim',
    opts = {
      terminal_colors = true,
      styles = {
        comments = {},
        keywords = {},
        identifiers = {},
        functions = {},
        variables = {},
        booleans = {},
      },
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = false,
        indent_blankline = true,
        lazy = true,
        lsp = true,
        markdown = true,
        mason = true,
        navic = false,
        neo_tree = false,
        neorg = false,
        noice = true,
        notify = true,
        rainbow_delimiters = true,
        telescope = true,
        treesitter = true,
      },
      highlight_overrides = {},
    },
  },
  -- }}}
}

-- Old Ones {{{
-- 'AlessandroYorba/Alduin'             " カ
-- 'NLKNguyen/papercolor-theme'         " ラ
-- 'aereal/vim-colors-japanesque'       " フ
-- 'altercation/vim-colors-solarized'   " ル
-- 'andreypopp/vim-colors-plain'        " ナ
-- 'cocopon/iceberg.vim'                " ヴ
-- 'freeo/vim-kalisi'                   " ィ
-- 'jacoborus/tender'                   " ム
-- 'jonathanfilip/vim-lucius'           " ゥ
-- 'lifepillar/vim-solarized8'          " ヤ
-- 'morhetz/gruvbox'                    " バ
-- 'rhysd/vim-color-spring-night'       " ス
-- 'vim-scripts/random.vim'             " キ
-- 'vim-scripts/zenesque.vim'           " ィ
-- 'reedes/vim-colors-pencil'           " !!
-- 'phucngodev/mono', {'branch':'main'} " 💚
-- 'fxn/vim-monochrome', {'branch':'main'}
-- 'owickstrom/vim-colors-paramount'
-- 'pbrisbin/vim-colors-off', {'branch':'main'}
-- 'yasukotelin/shirotelin'
-- 'sainnhe/sonokai'
-- 'sainnhe/edge'
-- 'sickill/vim-monokai'
-- }}}

for _, color in ipairs(colors) do
  color.lazy = false

  color.priority = require('anekos.priority').colors.colorscheme
end

return colors
