-- 括弧・クォートなどのペア文字を自動で閉じる。nvim-cmp との統合や filetype ごとの細かい制御が可能。
return {
  -- 括弧
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function(_, opts)
    local m = require('nvim-autopairs')
    m.setup(opts)
    m.get_rules('`')[1].not_filetypes = { 'markdown', 'nox' }
  end,
}
