-- Neovim と VS Code 間でファイルとカーソル位置をシームレスに同期・共有する。
return {
  'kbwo/vim-shareedit',
  dependencies = {
    'vim-denops/denops.vim',
  },
  cmd = {
    'ShareEditStart',
  },
  config = function()
  end,
}
