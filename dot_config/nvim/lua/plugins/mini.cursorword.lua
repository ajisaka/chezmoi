-- カーソル下の単語と同一の単語をバッファ全体で自動ハイライト表示する。遅延設定やモード別無効化が可能。
return {
  'echasnovski/mini.cursorword',
  event = 'CursorMoved',
  opts = {
    delay = 300,
  },
  cond = false,
}
