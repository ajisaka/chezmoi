-- LSP 診断・quickfix・位置リスト・検索結果をツリー形式のインタラクティブリストで表示する。
return {
  'folke/trouble.nvim',
  event = 'VeryLazy',
  cmd = {},
  dependencies = {
    -- 'kyazdani42/nvim-web-devicons',
  },
  opts = {},
}
