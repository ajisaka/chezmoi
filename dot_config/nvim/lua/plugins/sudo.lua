-- sudo が必要なファイルを :SudaRead/:SudaWrite で読み書きできる。スマートモードで自動判別も可能。
return {
  'lambdalisue/vim-suda',
  cmd = {
    'SudaRead',
    'SudaWrite',
  },
}
