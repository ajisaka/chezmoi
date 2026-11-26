-- Hugging Face API・Ollama・OpenAI など複数バックエンドに対応した LLM によるゴーストテキスト補完プラグイン。
local options = {
  ollama = { -- {{{
    backend = 'ollama',
    model = 'codellama:7b',
    url = 'http://localhost:11434', -- llm-ls uses "/api/generate"
    request_body = {
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },
  }, -- }}}

  huggingface = { -- {{{
    backend = 'huggingface',
    url = nil,
    model = 'bigcode/starcoder2-15b',
    request_body = {
      parameters = {
        -- max_new_tokens = 60,
        temperature = 0.2,
        top_p = 0.95,
      },
    },
  }, -- }}}

  openai = { -- {{{
    backend = 'openai', -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
    api_token = os.getenv('OPENAI_API_KEY'),
    url = 'https://api.openai.com', -- llm-ls uses "/v1/completions"
    model = 'gpt-3.5-turbo-instruct',
  }, -- }}}
}

local common = { -- {{{
  enable_suggestions_on_startup = true,
  tokens_to_clear = { '<|endoftext|>' }, -- tokens to remove from the model's output

  -- parameters that are added to the request body, values are arbitrary, you can set any field:value pair here it will be passed as is to the backend

  -- -- set this if the model supports fill in the middle
  fim = {
    enabled = false,
    prefix = '<fim_prefix>',
    middle = '<fim_middle>',
    suffix = '<fim_suffix>',
  },
  -- debounce_ms = 150,
  accept_keymap = '<S-CR>',
  -- dismiss_keymap = '<S-Tab>',
  -- tls_skip_verify_insecure = false,
  -- -- llm-ls configuration, cf llm-ls section
  lsp = {
    bin_path = vim.api.nvim_call_function('stdpath', { 'data' }) .. '/mason/bin/llm-ls',
    -- host = nil,
    -- port = nil,
    -- cmd_env = nil, -- or { LLM_LOG_LEVEL = "DEBUG" } to set the log level of llm-ls
    -- version = '0.5.3',
  },
  -- tokenizer = nil, -- cf Tokenizer paragraph
  -- context_window = 1024, -- max number of tokens for the context window
  -- enable_suggestions_on_files = '*', -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
  -- disable_url_path_completion = false, -- cf Backend
} -- }}}

return {
  'huggingface/llm.nvim',
  lazy = false,
  cond = false,
  cmd = {
    'LLMToggleAutoSuggest',
    'LLMSuggestion',
  },
  config = function()
    local llm = require('llm')

    -- local option = options.huggingface
    local option = options.ollama

    llm.setup(require('anekos.utils').merge_tables(common, option))
  end,
}
