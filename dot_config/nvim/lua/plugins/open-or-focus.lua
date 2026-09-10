-- 指定バッファが既に開いているウィンドウがあればフォーカスし、なければ新しいウィンドウで開く。
return {
  'anekos/open-or-focus.nvim',
  cond = false,
  event= 'VeryLazy',
  config = function ()
  end,
}
