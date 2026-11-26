-- `file.lua:10:3` のように行・列番号を含むパスを gf で正しく解釈してジャンプできるようにする。
return {
  'wsdjeg/vim-fetch',
  keys = {
    { 'gf', 'gF', mode = { 'n', 'v' }, desc = 'Fetch it' },
  },
}
