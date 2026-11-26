-- Ollama などのローカル LLM を使ってテキストの生成・編集・変換をエディタ内から対話的に行う。
require('anekos.menu').collect('ai') {
  { display = 'Gen Select Model', value = [[ lua require('gen').select_model() ]] },
}

return {
  'David-Kunz/gen.nvim',
  cmd = require('anekos.menu').collect('ai') { 'Gen' },
  keys = { '<leader>ag', '<Cmd>Gen<CR>', desc = 'Gen AI' },
  opts = {
    model = 'mistral:instruct',
    quit_map = 'q',
    retry_map = '<C-r>',
    accept_map = '<C-cr>',
    display_mode = 'float',
    no_auto_close = false,
    show_model = true,
  },
}
