-- ファイルを再度開いたときにカーソル位置・折りたたみ状態などを自動で復元する。
return {
  'vladdoster/remember.nvim',
  event = 'VeryLazy',
  config = function()
    require('remember').setup {}
  end,
}
