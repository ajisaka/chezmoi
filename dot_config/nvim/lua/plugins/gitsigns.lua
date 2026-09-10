-- Git の変更箇所をサインカラムに表示し、hunk 単位のステージ・プレビュー・blame 表示を提供する。
return {
  'lewis6991/gitsigns.nvim',
  cmd = { 'Gitsigns' },
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<Leader>gts', '<Cmd>Gitsign toggle_signs<CR>', 'n', desc = 'Git signs' },
    { '<Leader>gb', '<Cmd>Gitsign blame_line<CR>', 'n', desc = 'Blame line' },
    { '<Leader>gq', '<Cmd>Gitsigns setqflist all<CR>', 'n', desc = 'Git hunks to qf' },
  },
  opts = {
    signs = {
      add = { text = '✚' },
      change = { text = '✱' },
      delete = { text = '✖' },
      topdelete = { text = '✖' },
      changedelete = { text = '✱' },
      untracked = { text = '◌' },
    },
  },
}
