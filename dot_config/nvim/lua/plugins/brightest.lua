-- カーソル下の単語と同じ単語をバッファ全体で自動ハイライト表示する。ハイライトスタイルを柔軟にカスタマイズ可能。
return {
  'osyo-manga/vim-brightest',
  cond = false,
  event = 'CursorMoved',
}
