-- GitHub Copilot Chat を Neovim に統合し、コードの説明・修正・生成をチャット形式で対話的に行う。
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  event = 'InsertEnter',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  cmd = require('anekos.menu').collect('ai') {
    'CopilotChat',
    'CopilotChatOpen',
    'CopilotChatClose',
    'CopilotChatToggle',
    'CopilotChatStop',
    'CopilotChatReset',
    'CopilotChatSave',
    'CopilotChatLoad',
    'CopilotChatDebugInfo',
    'CopilotChatModels',
    'CopilotChatExplain',
    'CopilotChatReview',
    'CopilotChatFix',
    'CopilotChatOptimize',
    'CopilotChatDocs',
    'CopilotChatTests',
    'CopilotChatFixDiagnostic',
    'CopilotChatCommit',
    'CopilotChatCommitStaged',
  },
  keys = {
    { '<leader>ag', '<Cmd>CopilotChat<CR>', mode = { 'n', 'v' }, desc = 'Copilot chat' },
    -- Show help actions with telescope
    {
      '<leader>ah',
      function()
        require('CopilotChat').select_prompt()
      end,
      desc = 'CopilotChat - Help actions',
    },
    -- Show prompts actions with telescope
    {
      '<leader>ap',
      function()
        require('CopilotChat').select_prompt()
      end,
      desc = 'CopilotChat - Prompt actions',
    },
    -- Quick chat
    {
      '<leader>aq',
      function()
        local input = vim.fn.input('Quick Chat: ')
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
  },
  config = function()
    local select = require('CopilotChat.select')
    -- gitdiff, visual, unnamed, clipboard, buffer, line, diagnostics

    -- `/` COPILOT_INSTRUCTIONS COPILOT_EXPLAIN COPILOT_REVIEW COPILOT_GENERATE COPILOT_WORKSPACE SHOW_CONTEXT

    -- https://qiita.com/lx-sasabo/items/97c49d0f354ea3bdd525
    require('CopilotChat').setup {
      model = 'gpt-4o',
      prompts = {
        TypeHint = {
          prompt = '/COPILOT_GENERATE 型を追記してください。',
          selection = select.buffer,
        },
        Explain = {
          prompt = '/COPILOT_EXPLAIN コードの説明を段落をつけて書いてください。',
          selection = select.buffer,
        },
        Tests = {
          prompt = '/COPILOT_TESTS コードの詳細な単体テスト関数を書いてください。',
          selection = select.visual,
        },
        Fix = {
          prompt = '/COPILOT_GENERATE このコードには問題があります。バグを修正したコードに書き換えてください。',
          selection = select.buffer,
        },
        Optimize = {
          prompt = '/COPILOT_GENERATE コードを最適化し、パフォーマンスと可読性を向上させてください。',
          selection = select.buffer,
        },
        Docs = {
          prompt = '/COPILOT_GENERATE 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
          selection = select.visual,
        },
        FixDiagnostic = {
          prompt = 'ファイル内の次のような診断上の問題を解決してください：',
          selection = select.diagnostics,
        },
      },
    }
  end,
}
