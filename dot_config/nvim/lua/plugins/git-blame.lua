-- Git blame line on popup hint
return {
  'f-person/git-blame.nvim',
  keys = {
    { '<Leader>gB', '<Cmd>GitBlameToggle<CR>', mode = { 'n' }, desc = 'Toggle Git blame' },
  },
  cmd = {
    'GitBlameCopyCommitURL',
    'GitBlameCopyFileURL',
    'GitBlameCopySHA',
    'GitBlameDisable',
    'GitBlameEnable',
    'GitBlameOpenCommitURL',
    'GitBlameOpenFileURL',
    'GitBlameToggle',
  },
  opts = {
    enabled = false,
  },
}
