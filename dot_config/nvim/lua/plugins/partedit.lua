-- バッファの一部を別バッファで編集し、完了時に元の場所へ書き戻すパートエディタ。
return {
  'thinca/vim-partedit',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = {
    'Partedit'
  },
}
