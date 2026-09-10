-- LSP の UI を強化するプラグイン。コードアクション・hover・定義プレビュー・アウトラインをモダンな UI で提供する。
return {
  'nvimdev/lspsaga.nvim',
  -- event = { 'VeryLazy' },
  keys = {
    { '<Leader>ls', ':<C-u>Lspsaga<Space>', desc = 'LSP saga' },
    { '<Leader>la', '<Cmd>Lspsaga code_action<CR>', desc = 'LSP action' },
    { '<Leader>lf', '<Cmd>Lspsaga finder<CR>', desc = 'LSP fidner' },
    { '<Leader>li', '<Cmd>Lspsaga show_buf_diagnostics<CR>', desc = 'LSP diag buf' },
    { '<Leader>lI', '<Cmd>Lspsaga show_workspace_diagnostics<CR>', desc = 'LSP diag workspace' },
    { '<Leader>lo', '<Cmd>Lspsaga outline<CR>', desc = 'LSP outline' },
    { '<Leader>lr', '<Cmd>Lspsaga rename<CR>', desc = 'LSP rename' },
    { 'gp', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', desc = 'LSP diag prev' },
    { 'gn', '<Cmd>Lspsaga diagnostic_jump_next<CR>', desc = 'LSP diag next' },
    { 'gd', '<Cmd>Lspsaga peek_definition<CR>', desc = 'LSP peek definition' },
    { 'gD', '<Cmd>Lspsaga goto_definition<CR>', desc = 'LSP goto definition' },
  },
  config = function()
    require('lspsaga').setup {
      lightbulb = {
        enabled = true,
        sign = false,
        virtual_text = true,
      },
      finder = {
        default = 'tyd+ref+imp+def',
        methods = {
          tyd = 'textDocument/typeDefinition',
        },
      },
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-tree/nvim-web-devicons',
  },
}
