-- <C-a>/<C-x> によるインクリメント・デクリメントを日付・真偽値・HEX・日本語曜日など多彩な型に拡張する。
return {
  'monaqa/dial.nvim',
  tag = 'v0.4.1',
  -- dial.nvim の新機能紹介：ノーマルモード g<C-a> https://zenn.dev/vim_jp/articles/2023-04-12-vim-dial-additive-increment
  keys = {
    { '<C-a>', '<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true, desc = '++' },
    { '<C-x>', '<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true, desc = '--' },
    { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true, desc = '++' },
    { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true, desc = '--' },
    { '<C-a>', '<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true, desc = '++' },
    { '<C-x>', '<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true, desc = '--' },
    { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true, desc = '++' },
    { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true, desc = '--' },
  },
  config = function()
    local augend = require('dial.augend')

    require('dial.config').augends:register_group {
      -- default augends used when no group name is specified
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d'],
        augend.date.alias['%H:%M'],
        augend.constant.new {
          elements = { "月", "火", "水", "木", "金", "土", "日" },
          word = false,
          cyclic = true,
        },
      },
    }

    require('dial.config').augends:on_filetype {
      liname = {
        augend.constant.new{
          elements = {"上", "中", "下"},
          word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
          cyclic = true,  -- "or" is incremented into "and".
        },
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
      },
      python = {
        augend.constant.new {
          elements = { 'True', 'False' },
          word = true,
          cyclic = true,
        },
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d'],
        augend.date.alias['%H:%M'],
      },
    }
  end,
}
