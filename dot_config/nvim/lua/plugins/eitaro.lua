-- カーソル下の単語を辞書引きするプライベートプラグイン（特定ホストのみで有効）。
return {
  'anekos/eitaro.vim',
  name = 'eitaro',
  cond = vim.g.anekos_vim_private == 1 and vim.fn.hostname() == 'ildjarn.local.anekos.com',
  dir = '~/project/eitaro.vim',
  keys = {
    { '<Leader>e', '<plug>(eitaro-lookup-inside)', mode = { 'n', 'v' }, remap = true, silent = true, desc = 'Eitaro' },
  },
}
