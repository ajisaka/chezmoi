-- ノーマルモード移行時に fcitx を自動オフにし、インサートモード復帰時に入力メソッドの状態を復元する。
return {
  'h-hg/fcitx.nvim',
  cond = true,
  event = 'InsertEnter',
}
