-- レジスタの内容で対象テキストを置換するオペレータ。置換後もレジスタの内容が変わらない。
return {
  'kana/vim-operator-replace',
  keys = {
    { '_', '<Plug>(operator-replace)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Operator replace' },
  },
  dependencies = { 'kana/vim-operator-user' },
}
