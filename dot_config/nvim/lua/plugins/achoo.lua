-- セッションの保存・読み込み・削除と自動保存を管理するセッションマネージャー。
return {
  'anekos/achoo.nvim',
  cmd = {
    'AchooAutoSave',
    'AchooDelete',
    'AchooLoad',
    'AchooSave',
    'AchooEdit',
  },
  event = { 'VeryLazy' },
  keys = {
    { 'Sss', '<Cmd>AchooSave<CR>', mode = { 'n' }, desc = 'Save session' },
    { 'Ssr', '<Cmd>AchooLoad<CR>', mode = { 'n' }, desc = 'Load session' },
    { 'Sst', '<Cmd>AchooAutoSave<CR>', mode = { 'n' }, desc = 'Toggle auto session' },
    { 'Ssu', '<Cmd>AchooUpdate<CR>', mode = { 'n' }, desc = 'Update session' },
  },
  config = function()
    require('lazy').load { plugins = { 'nox-vim' } } -- 'fern'
    require('achoo').setup {
      auto_save = true,
      icon = require('achoo.icon').predefined.nerd,
      confirm_on_leave = false,
      postprocess = true,
      preprocess = true,
      session_rotation = true,
    }

    require('telescope').load_extension('achoo')
  end,
}
