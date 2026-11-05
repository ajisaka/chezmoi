-- OpenAI・Anthropic・Gemini など複数 LLM プロバイダに対応したチャット・テキスト補完プラグイン。
-- Hooks {{{

local hooks = {
  Ask = function(parrot, params)
    local template = [[
		  In light of your existing knowledge base, please generate a response that
		  is succinct and directly addresses the question posed. Prioritize accuracy
		  and relevance in your answer, drawing upon the most recent information
		  available to you. Aim to deliver your response in a concise manner,
		  focusing on the essence of the inquiry.
		  Question: {{command}}
		]]
    local agent = parrot.get_command_agent()
    parrot.logger.info('Asking agent: ' .. vim.inspect(agent.name))
    parrot.Prompt(params, parrot.ui.Target.vnew, agent, '🤖 Ask ~ ', template)
  end,
  Review = function(prt, params)
    local chat_prompt = [[
        あなたのタスクは、提供された {{filetype}} コードを分析し、修正またはパフォーマンスを最適化するための改善を提案することです。
        コードをより効率的、高速化、またはリソースの消費量を削減できる領域を特定します。
        最適化のための具体的な提案と、これらの変更によってコードのパフォーマンスがどのように向上するかについての説明が提供されます。
        最適化されたコードは、効率の向上を示しながら、元のコードと同じ機能を維持する必要があります。ここにコードがあります
        ```{{filetype}}
        {{filecontent}}
        ```
    ]]
    prt.cmd.ChatNew(params, chat_prompt)
  end,
  Fix = function(prt, params)
    local chat_prompt = [[
      Please fix bugs in below {{filetype}} dode.
      ```{{filetype}}
      {{filecontent}}
      ```
      Please rewrite this according to the contained instructions.
      Respond exclusively with the snippet that should replace the selection above.
      No comments, just the code!!!
    ]]
    local agent = prt.get_command_agent()
    prt.Prompt(params, prt.ui.Target.rewrite, agent, nil, chat_prompt)
  end,
  TellBugs = function(prt, params)
    local chat_prompt = [[
      あなたのタスクは、以下の {{filetype}} コードを分析し、修正することです。
      ```{{filetype}}
      {{filecontent}}
      ```
    ]]
    local agent = prt.get_command_agent()
    prt.Prompt(params, prt.ui.Target.vnew, agent, nil, chat_prompt)
  end,
  Typing = function(prt, params)
    local chat_prompt = [[
      Your task is to add types in the {{filetype}} code below.
      ```{{filetype}}
      {{filecontent}}
      ```
      Please rewrite this according to the contained instructions.
      Respond exclusively with the snippet that should replace the selection above.
      No comments, just the code!!!
    ]]
    local agent = prt.get_command_agent()
    prt.Prompt(params, prt.ui.vnew, agent, nil, chat_prompt)
  end,
}

-- }}}

-- Init {{{

local cmd = require('anekos.menu').collect('ai') {
  'PrtAgent',
  'PrtAppend',
  'PrtAsk',
  'PrtChatDelete',
  'PrtChatFinder',
  'PrtChatNew',
  'PrtChatPaste',
  'PrtChatRespond',
  'PrtChatToggle',
  'PrtContext',
  'PrtEnew',
  'PrtImplement',
  'PrtInfo',
  'PrtNew',
  'PrtPopup',
  'PrtPrepend',
  'PrtProvider',
  'PrtRewrite',
  'PrtStop',
  'PrtTabnew',
  'PrtVnew',
}

for hook, _ in pairs(hooks) do
  table.insert(cmd, 'Prt' .. hook)
end

-- }}}

-- Config {{{

return {
  'frankroeder/parrot.nvim',
  tag = 'v0.3.9',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  cmd = cmd,
  config = function()
    require('parrot').setup {
      providers = {
        pplx = {
          api_key = os.getenv('PERPLEXITY_API_KEY'),
        },
        openai = {
          api_key = os.getenv('OPENAI_API_KEY'),
        },
        anthropic = {
          api_key = os.getenv('ANTHROPIC_API_KEY'),
        },
        mistral = {
          api_key = os.getenv('MISTRAL_API_KEY'),
        },
      },
      agents = {
        chat = {
          {
            name = 'Llama3-Sonar-Small-128k-Chat',
            model = { model = 'llama-3.1-sonar-small-128k-chat', temperature = 1.1, top_p = 1 },
            system_prompt = 'Hi!',
            provider = 'pplx',
          },
          {
            name = 'Llama3-Sonar-Large-128k-Chat',
            model = { model = 'llama-3.1-sonar-large-128k-chat', temperature = 1.1, top_p = 1 },
            system_prompt = 'Hi!',
            provider = 'pplx',
          },
          {
            name = 'Llama3.1-8B-Instruct',
            model = { model = 'llama-3.1-8b-instruct', temperature = 1.1, top_p = 1 },
            system_prompt = 'Hi!',
            provider = 'pplx',
          },
          {
            name = 'Llama3.1-70B-Instruct',
            model = { model = 'llama-3.1-70b-instruct', temperature = 1.1, top_p = 1 },
            system_prompt = 'Hi!',
            provider = 'pplx',
          },
        },
        command = {
          {
            name = 'Llama3.1-Sonar-Small-128k--Online',
            model = { model = 'llama-3.1-sonar-small-128k-online', temperature = 0.8, top_p = 1 },
            provider = 'pplx',
          },
          {
            name = 'Llama3.1-Sonar-Large-128k--Online',
            model = { model = 'llama-3.1-sonar-large-128k-online', temperature = 0.8, top_p = 1 },
            provider = 'pplx',
          },
        },
      },
      hooks = hooks,
    }
  end,
}

-- }}}
