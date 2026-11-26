-- Markdown をフローティングウィンドウ・タブ・ページャーでリッチレンダリングする。表・コードブロック・画像・Mermaid 図に対応。
return {
  'delphinus/md-render.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', version = '*' }, -- optional: file type icons in code blocks
    { 'delphinus/budoux.lua', version = '*' }, -- optional: CJK phrase-level line breaking
  },
  cmd = {
    'MdRender',
    'MdRenderTab',
    'MdRenderPager',
    'MdRenderDemo',
  },
  keys = {
    { '<leader>mp', '<Plug>(md-render-preview)', desc = 'Markdown preview (toggle)' },
    { '<leader>mt', '<Plug>(md-render-preview-tab)', desc = 'Markdown preview in tab (toggle)' },
  },
}
