-- OpenAI の ChatGPT API を Neovim に統合し、コード補完・編集・AI アクションをエディタ内で実行できる。
return {
  'jackMort/ChatGPT.nvim',
  cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTEditWithInstructions', 'ChatGPTRun' },
  opts = {
    actions_paths = {
      vim.fn.expand('~/.config/nvim/lua/plugins/ChatGPT/actions.json'),
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    -- See ~/.local/share/nvim/lazy/ChatGPT.nvim/lua/chatgpt/config.lua as default values
    require('chatgpt').setup {
      chat = {
        edit_with_instructions = {
          diff = false,
          keymaps = {
            close = '<C-g>',
            accept = '<C-y>',
            toggle_diff = '<C-d>',
            toggle_settings = '<C-o>',
            toggle_help = '<C-/>',
            cycle_windows = '<Tab>',
            use_output_as_input = '<C-i>',
          },
        },
        keymaps = {
          close = { '<C-g>', '<Esc>' },
          yank_last = '<C-y>',
          yank_last_code = '<C-k>',
          scroll_up = '<C-u>',
          scroll_down = '<C-d>',
          new_session = '<C-n>',
          cycle_windows = '<Tab>',
          cycle_modes = '<C-f>',
          next_message = '<C-j>',
          prev_message = '<C-k>',
          select_session = '<Space>',
          rename_session = 'r',
          delete_session = 'd',
          draft_message = '<C-r>',
          edit_message = 'e',
          delete_message = 'd',
          toggle_settings = '<C-o>',
          toggle_sessions = '<C-p>',
          toggle_help = '<C-/>',
          toggle_message_role = '<C-r>',
          toggle_system_role_open = '<C-s>',
          stop_generating = '<C-c>',
        },
      },
      openai_params = {
        model = 'gpt-4-turbo',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 300,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = 'gpt-4-turbo',
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    }
  end,
}
