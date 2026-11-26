-- Git の diff・マージコンフリクト・ファイル履歴を統一タブ UI でまとめて閲覧・操作する。
return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'DiffviewOpen',
    'DiffviewFileHistory',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
    'DiffviewLog',
  },
  config = function()
    require('diffview').setup {
      use_icons = true,
    }
  end,
}
