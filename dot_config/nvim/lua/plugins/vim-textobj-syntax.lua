-- シンタックスハイライトが同じ連続した領域をテキストオブジェクトとして操作できるようにする。
return {
  'kana/vim-textobj-syntax',
  event = { 'VeryLazy' },
  dependencies = {
    'kana/vim-textobj-user',
  },
  config = function()
    vim.cmd.TextobjSyntaxDefaultKeyMappings()
  end,
}
