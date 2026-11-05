-- 存在しないパスへファイルを保存するとき、必要な親ディレクトリを自動で作成する。
return {
  'travisjeffery/vim-auto-mkdir',
  event = 'CmdlineEnter',
}
