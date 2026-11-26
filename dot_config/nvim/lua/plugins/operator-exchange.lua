-- cx でテキスト範囲を2回マークして、その2つの領域を入れ替える交換オペレータ。
return {
  'tommcdo/vim-exchange',
  keys = {
    { 'X', mode = { 'v' }, desc = 'Cold exchange' },
  },
  dependencies = { 'kana/vim-operator-user' },
}
