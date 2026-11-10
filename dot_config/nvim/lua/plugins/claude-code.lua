-- Anthropic の Claude Code AI アシスタントを Neovim に統合し、WebSocket 経由でリアルタイムにコード編集を行う。
require('anekos.menu').collect('ai') {
  { display = 'ClaudeCode', value = [[ ClaudeCode ]] },
  { display = 'ClaudeCode Focus', value = [[ ClaudeCodeFocus ]] },
  { display = 'ClaudeCode Resume', value = [[ ClaudeCode --resume ]] },
  { display = 'ClaudeCode Continue', value = [[ ClaudeCode --continue ]] },
  { display = 'ClaudeCode Select Model', value = [[ ClaudeCodeSelectModel ]] },
  { display = 'ClaudeCode Add current buffer', value = [[ ClaudeCodeAdd % ]] },
  { display = 'ClaudeCode External Terminal', value = [[ ClaudeCodeExternalTerminal ]] },
}

local window_width = 0.5
local window_position = 'float'

local initialized = false
local terminal_opts = {
  snacks_win_opts = {
    position = window_position,
    width = function()
      return math.floor(vim.o.columns * window_width)
    end,
    col = 0.95,
    border = 'rounded',
    title = ' Claude Code ',
    title_pos = 'center',
  },
  provider = nil,
  provider_opts = {
    external_terminal_cmd = 'kitty -e %s',
  },
}

local function reopen()
  local term = require('claudecode.terminal')._get_managed_terminal_for_test()
  if term and term:buf_valid() then
    -- セッションを維持したままウィンドウだけ再作成
    term.opts.position = window_position
    if term:win_valid() then
      term:hide()
    end
    vim.schedule(function()
      term:show()
    end)
  else
    -- セッションなし: opts を更新して新規オープン
    terminal_opts.snacks_win_opts.position = window_position
    require('claudecode.terminal').setup(terminal_opts)
    vim.cmd('ClaudeCodeFocus')
  end
end

return {
  'coder/claudecode.nvim',
  cmd = { 'ClaudeCode', 'ClaudeCodeFocus' },
  dependencies = { 'folke/snacks.nvim' },
  keys = {
    { '<C-;>', '<Cmd>ClaudeCodeFocus<CR>', desc = 'Focus Claude' },
    { '<C-;>', '<C-\\><C-n>:ClaudeCodeFocus<CR>', desc = 'Focus Claude', mode = 't' },
    { '<Leader>aa', nil, desc = 'AI/Claude Code' },
    { '<Leader>aC', '<Cmd>ClaudeCode --continue<CR>', desc = 'Continue Claude' },
    { '<Leader>aa', '<Cmd>ClaudeCode<CR>', desc = 'Toggle Claude' },
    { '<Leader>ab', '<Cmd>ClaudeCodeAdd %<CR>', desc = 'Add current buffer' },
    { '<Leader>af', '<Cmd>ClaudeCodeFocus<CR>', desc = 'Focus Claude' },
    { '<Leader>am', '<Cmd>ClaudeCodeSelectModel<CR>', desc = 'Select Claude model' },
    { '<Leader>ar', '<Cmd>ClaudeCode --resume<CR>', desc = 'Resume Claude' },
    { '<Leader>as', '<Cmd>ClaudeCodeSend<CR>', desc = 'Send to Claude', mode = 'v' },
    {
      '<Leader>as',
      '<Cmd>ClaudeCodeTreeAdd<CR>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
    },
    {
      '<leader>ac',
      function()
        require('telescope.builtin').find_files {
          attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)
              vim.cmd('ClaudeCodeAdd ' .. selection.path)
            end)
            return true
          end,
        }
      end,
      desc = 'Add file to claude context',
    },
    {
      '<leader>aw',
      function()
        local count = vim.v.count
        if count > 0 then
          window_width = count / 100
        end
        reopen()
      end,
      desc = 'Reopen Claude (count = window width%, e.g. 40<leader>aw)',
    },
    {
      '<leader>aW',
      function()
        window_position = window_position == 'float' and 'right' or 'float'
        reopen()
      end,
      desc = 'Toggle Claude position (float/right)',
    },
    -- Diff management
    { '<Leader>a<', '<cmd>ClaudeCodeDiffDeny<CR>', desc = 'Deny diff' },
    { '<Leader>a>', '<cmd>ClaudeCodeDiffAccept<CR>', desc = 'Accept diff' },
  },

  opts = {
    terminal = terminal_opts,
    diff_opts = {
      layout = 'vertical', -- 'horizontal'
      keep_terminal_focus = false,
      open_in_new_tab = true,
      hide_terminal_in_new_tab = true,
      -- on_new_file_reject = 'keep_empty'|'close_window'
    },
  },

  init = function()
    vim.keymap.set('n', '<Leader>ae', function()
      if initialized then
        vim.notify('ClaudeCode is already initialized', { level = vim.log.levels.ERROR })
        return
      end
      terminal_opts.provider = 'external'
      vim.cmd('ClaudeCode')
    end, { noremap = true })
  end,

  config = function(_, opts)
    initialized = true
    require('claudecode').setup(opts)
  end,
}
