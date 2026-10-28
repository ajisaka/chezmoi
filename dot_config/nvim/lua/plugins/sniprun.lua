-- 選択コードをその場で即時実行して結果を表示する。REPL ライクな動作や複数言語・複数表示モードに対応。
return {
  'michaelb/sniprun',
  cmd = {
    'SnipRun',
    'SnipInfo',
  },
  opts = {},
  build = vim.g.anekos_vim_private and 'sh install.sh 1',
  config = function()
    require('sniprun').setup {}
  end,
}
