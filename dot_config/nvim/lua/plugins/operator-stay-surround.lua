-- テキストオブジェクトを指定ペア文字で囲む・削除・置換するオペレータを提供する vim-surround の代替。
return {
  'rhysd/vim-operator-surround',
  keys = {
    { 'gu', '<Plug>(operator-stay-cursor-gu)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Stay cursor gu' },
    { 'gU', '<Plug>(operator-stay-cursor-gU)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Stay cursor gU' },
    { 'Sa', '<Plug>(operator-surround-append)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Surround append' },
    { 'Sd', '<Plug>(operator-surround-delete)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Surround delete' },
    { 'Sr', '<Plug>(operator-surround-replace)', mode = { 'n', 'v', 'o' }, remap = true, desc = 'Surround replace' },
    {
      'Sdd',
      '<Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)',
      mode = { 'n', 'v', 'o' },
      remap = true,
      desc = 'Surround delete',
    },
    {
      'Srr',
      '<Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)',
      mode = { 'n', 'v', 'o' },
      remap = true,
      desc = 'Surround replace',
    },
  },
  dependencies = { 'kana/vim-operator-user' },
  init = function()
    local mw = { 'char', 'line', 'block' }

    vim.g['operator#surround#blocks'] = {
      ['-'] = {
        { block = { '{', '}' }, motionwise = mw, keys = { 'b', '7', '8' } },
        { block = { '[', ']' }, motionwise = mw, keys = { 's', 'u', 'i' } },
        { block = { '(', ')' }, motionwise = mw, keys = { 'p', 'j', 'k' } },
        { block = { '<', '>' }, motionwise = mw, keys = { 't', 'm', 'l' } },
      },
    }
  end,
}
