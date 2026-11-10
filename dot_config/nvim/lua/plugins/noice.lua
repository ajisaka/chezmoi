-- コマンドライン・メッセージ・ポップアップメニューをモダンな UI に置き換える。LSP ドキュメントも Treesitter でレンダリング。
return {
  'folke/noice.nvim',
  cond = function()
    -- return vim.fn.has('gui_running') == 1
    return false
  end,
  event = 'UIEnter',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- dialog for `smjonas/inc-rename.nvim`
      lsp_doc_border = false, -- add a border to hover docs and signature help
      command_palette = false, -- position the cmdline and popupmenu together
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup {
          timeout = 1000,
        }
        require('telescope').load_extension('notify')
      end,
    },
  },
}
