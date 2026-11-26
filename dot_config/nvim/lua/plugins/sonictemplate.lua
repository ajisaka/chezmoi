-- ファイルタイプ別のコードテンプレートを瞬時に挿入するテンプレートプラグイン。
return {
  'mattn/vim-sonictemplate',
  init = function()
    vim.g.sonictemplate_key = '<plug>'
    vim.g.sonictemplate_intelligent_key = '<plug>'
    vim.g.sonictemplate_postfix_key = ''
    vim.g.sonictemplate_vim_template_dir = { '~/.config/nvim/template' }
  end,
}
