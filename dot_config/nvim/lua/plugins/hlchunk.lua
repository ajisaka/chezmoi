-- カーソル位置のコードブロックとインデント行をハイライト表示する。非同期描画で高速動作する。
return {
  'shellRaining/hlchunk.nvim',
  ft = { 'lua', 'python', 'typescript' },
  config = function ()
    require('hlchunk').setup({
      chunk = {
        enable = true,
      },
      indent = {
        enable = false,
      },
    })
  end
}
