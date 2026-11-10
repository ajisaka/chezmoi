-- Tree-sitter ノード種別ごとにコメント文字列をカスタマイズし、より正確なコメント操作を提供する。
return {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
