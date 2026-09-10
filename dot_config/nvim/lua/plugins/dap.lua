-- Debug Adapter Protocol (DAP) クライアント。ブレークポイント設定・ステップ実行・変数確認などのデバッグ操作を提供する。
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = { virt_text_pos = 'eol' },
    },
  },
  keys = {
    {
      '<Leader>dc',
      function()
        require('dap').continue()
      end,
      mode = { 'n' },
      desc = 'DAP Continue',
    },
    {
      '<Leader>dt',
      function()
        require('dap').toggle_breakpoint()
      end,
      mode = { 'n' },
      desc = 'DAP breakpoint',
    },
    {
      '<Leader>du',
      function()
        require('dapui').toggle()
      end,
      mode = { 'n' },
      desc = 'DAP UI',
    },
    {
      '<Leader>dr',
      function()
        require('dap').run_last()
      end,
      mode = { 'n' },
      desc = 'DAP Re-Run',
    },
    {
      '<Leader>de',
      function()
        require('dapui').eval()
        require('dapui').eval()
      end,
      mode = { 'n' },
      desc = 'DAP Evaluate expression',
    },
    -- :DapContinue<CR>
    -- :DapStepOver<CR>
    -- :DapStepInto<CR>
    -- :DapStepOut<CR>
    -- :DapToggleBreakpoint<CR>
    -- :lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>
    -- :lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>
    -- :lua require("dap").repl.open()<CR>
    -- :lua require("dap").run_last()<CR>
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup {}
    require('dap-python').setup('python')

    require('lazy').load { plugins = { 'overseer.nvim' } }
    require('overseer').enable_dap()

    -- Automatically open the UI when a new debug session is created.
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open {}
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close {}
    end
  end,
}
