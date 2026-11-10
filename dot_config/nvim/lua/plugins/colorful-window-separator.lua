-- アクティブウィンドウの境界線をカラフルに表示し、tmux のペインのように視覚的に区別できる。
return {
  'nvim-zh/colorful-winsep.nvim',
  event = 'WinEnter',
  cond = false,
  opts = {}
}
