-- ls・cp・rm など一般的な UNIX シェルコマンドをエミュレートして Vim 内から直接実行できる。
return {
  'b4b4r07/vim-shellutils',
  cmd = { 'Ls', 'Mv', 'Cp', 'File', 'Cat', 'Head', 'Tail', 'Touch', 'Mkdir', 'Rm' },
}
