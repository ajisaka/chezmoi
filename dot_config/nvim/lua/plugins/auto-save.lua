-- 変更されたバッファをトリガーイベントに応じて自動保存する。デバウンスや除外条件の細かい設定が可能。
return {
  'okuuva/auto-save.nvim',
  cmd = { 'ASToggle' },
  opts = {
    enabled = false,
  },
}
