-- カーソルがファイルパス上にあるとき、画像・PDF・SVG などをターミナル内で自動プレビューする。
return {
  'anekos/preview-on-console.nvim',
  cmd = {
    'POCEnable',
    'POCToggle',
    'POCDisable',
  },
  ft = { 'liname' },
  config = function()
    require('preview-on-console').setup()
  end,
}
