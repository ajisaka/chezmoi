-- scrolloff を行数ではなくウィンドウ高さのパーセンテージで設定し、リサイズ時に自動調整する。
return {
  'tonymajestro/smart-scrolloff.nvim',
  opts = {
    scrolloff_percentage = 0.2,
  },
}
