-- Markdown をブラウザでリアルタイムプレビューする。同期スクロール・数式・Mermaid 図・絵文字の描画に対応。
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown', 'nox' }
  end,
  ft = { 'markdown', 'nox' },
}
