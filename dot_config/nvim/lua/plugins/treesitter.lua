-- 多言語に対応した構文解析エンジン。シンタックスハイライト・インデント・テキストオブジェクトをより正確に提供する。
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  cond = false,
  event = { 'BufReadPost', 'BufNewFile' },
  -- build = ':TSUpdate',
  cmd = {
    'TSBufDisable',
    'TSBufEnable',
    'TSBufToggle',
    'TSConfigInfo',
    'TSDisable',
    'TSEditQuery',
    'TSEditQueryUserAfter',
    'TSEnable',
    'TSInstall',
    'TSInstallFromGrammar',
    'TSInstallInfo',
    'TSInstallSync',
    'TSModuleInfo',
    'TSToggle',
    'TSUninstall',
    'TSUpdate',
    'TSUpdateSync',
  },
  dependencies = {
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- require('nvim-treesitter.configs').setup {
    --   modules = {},
    --   sync_install = false,
    --   ignore_install = { 'javascript' },
    --   ensure_installed = {
    --     'bash',
    --     'css',
    --     'dockerfile',
    --     'go',
    --     'gomod',
    --     'gosum',
    --     'gowork',
    --     'hcl',
    --     'html',
    --     'javascript',
    --     'jsdoc',
    --     'json',
    --     'json5',
    --     'jsonc',
    --     'jq',
    --     'lua',
    --     'luadoc',
    --     'luap',
    --     'markdown',
    --     'markdown_inline',
    --     'python',
    --     'regex',
    --     'rust',
    --     'sql',
    --     'tsx',
    --     'typescript',
    --     'vim',
    --     'vimdoc',
    --     'yaml',
    --   },
    --   auto_install = false,
    --   highlight = {
    --     -- enable = { 'rust' },
    --     disable = {},
    --   },
    --   indent = {
    --     -- enable = { 'rust' },
    --     disable = {},
    --   },
    --   incremental_selection = {
    --     -- enable = { 'rust' },
    --     disable = {},
    --     keymaps = {},
    --   },
    --
    --   -- textobjects
    --   textobjects = {
    --     select = {
    --       enable = true,
    --
    --       lookahead = true,
    --
    --       keymaps = {
    --         ['af'] = '@function.outer',
    --         ['if'] = '@function.inner',
    --         ['ac'] = '@class.outer',
    --         ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
    --         ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
    --       },
    --       -- You can choose the select mode (default is charwise 'v')
    --       --
    --       -- Can also be a function which gets passed a table with the keys
    --       -- * query_string: eg '@function.inner'
    --       -- * method: eg 'v' or 'o'
    --       -- and should return the mode ('v', 'V', or '<c-v>') or a table
    --       -- mapping query_strings to modes.
    --       selection_modes = {
    --         ['@parameter.outer'] = 'v', -- charwise
    --         ['@function.outer'] = 'V', -- linewise
    --         ['@class.outer'] = '<c-v>', -- blockwise
    --       },
    --       -- If you set this to `true` (default is `false`) then any textobject is
    --       -- extended to include preceding or succeeding whitespace. Succeeding
    --       -- whitespace has priority in order to act similarly to eg the built-in
    --       -- `ap`.
    --       --
    --       -- Can also be a function which gets passed a table with the keys
    --       -- * query_string: eg '@function.inner'
    --       -- * selection_mode: eg 'v'
    --       -- and should return true or false
    --       include_surrounding_whitespace = true,
    --     },
    --   },
    -- }
  end,
}
