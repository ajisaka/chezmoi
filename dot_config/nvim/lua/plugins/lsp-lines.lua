-- LSP の診断メッセージを行末バーチャルテキストではなく仮想行として複数行で表示し、視認性を高める。
return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = { 'VeryLazy' },
  config = function()
    require('lsp_lines').setup {}
    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = false,
    }
  end,
}
