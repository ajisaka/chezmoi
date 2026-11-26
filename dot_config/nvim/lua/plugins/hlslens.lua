-- 検索時にマッチ数・位置をバーチャルテキストで表示し、検索結果をより見やすくする。
return {
  'kevinhwang91/nvim-hlslens',
  config = function()
    require('hlslens').setup()
  end,
  keys = {
    { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
    { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
    { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
    { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
    { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
    { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
  },
}
