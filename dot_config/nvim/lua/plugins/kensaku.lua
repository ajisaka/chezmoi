-- ローマ字入力で日本語テキストを検索できる Migemo ベースの検索プラグイン。外部 C ライブラリ不要。
return {
  'lambdalisue/kensaku.vim',
  cond = vim.fn.executable('deno'),
  cmd = { 'Kensaku' },
  keys = {
    { '<Leader>/', ':<C-u>Kensaku<Space>', desc = 'Kensaku' },
  },
  dependencies = {
    'vim-denops/denops.vim',
    'lambdalisue/kensaku-command.vim',
  },
}
