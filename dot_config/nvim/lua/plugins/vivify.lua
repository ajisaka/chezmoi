-- Vivify (Markdown previewer) と連携するプラグイン
-- `:Toggle` というイカれたコマンドがあります
-- `viv ${MARKDOWN_FILE}` で、起動しておくと、そのファイルの編集時に反映される
return {
  'Imamiland/neovim-vivify-markdown.nvim',
  ft = { 'markdown' },
  version = 'stable',
}
