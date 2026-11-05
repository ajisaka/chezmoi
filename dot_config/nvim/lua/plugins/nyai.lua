-- AI とのチャットを専用フォーマット（nyai）で管理するプラグイン。フローティングウィンドウでの対話やモデル切り替えに対応。
return {
  'anekos/nyai.nvim',
  ft = { 'nyai' },
  cmd = require('anekos.menu').collect('ai') { 'NyaiChat', 'NyaiFloat', 'NyaiModel' },
  keys = {
    { '<Leader>af', '<Cmd>NyaiFloat<CR>', mode = { 'n' } },
    { '<Leader>aF', '<Cmd>NyaiFloat!<CR>', mode = { 'n' } },
    { '<Leader>am', '<Cmd>NyaiModel<CR>', mode = { 'n' } },
  },

  config = function()
    local function if_has_ollama(f)
      if vim.g.anekos_vim_hostname == 'ildjarn.local.anekos.com' then
        return f()
      end
      return nil
    end

    local ogen = require('nyai.provider.generate').ollama

    local cmp_model = ogen('cmp', 'deepseek-coder-v2', true)
    -- local cmp_model = ogen('cmp', 'codellama:latest', false)

    require('nyai').setup {
      user_models = if_has_ollama(function()
        return require('nyai.provider.chat').ollama_generate()
      end),
      cmp_model = if_has_ollama(function()
        return cmp_model
      end),
      insert_default_model = true,
    }
  end,

  -- config = function()
  --   local function if_has_ollama(f)
  --     if vim.g.anekos_vim_hostname == 'ildjarn.local.anekos.com' then
  --       return f()
  --     end
  --     return nil
  --   end
  --
  --   local open = require('nyai.provider').ollama
  --
  --   require('nyai').setup {
  --     user_models = if_has_ollama(function()
  --       return require('nyai.provider').ollama_generate()
  --     end),
  --     insert_default_model = true,
  --   }
  -- end,
}
