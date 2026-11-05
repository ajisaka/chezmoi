-- タグ・日記・タスク・バックリンク・OGP 取得を備えた個人用ノート管理システム（プライベートプラグイン）。
return {
  'anekos/nox-vim',
  lazy = vim.fn.argc() == 0,
  cond = vim.g.anekos_vim_private == 1,
  cmd = {
    'NoxAttach',
    'NoxBackref',
    'NoxBrowse',
    'NoxDelete',
    'NoxDiary',
    'NoxDraft',
    'NoxGo',
    'NoxOgp',
    'NoxOpen',
    'NoxRename',
    'NoxSearch',
    'NoxTag',
    'NoxTasks',
  },
  keys = {
    { '<Leader>ns', ':<C-u>NoxSearch<Space>', desc = 'Nox search' },
    { '<Leader>nl', '<Cmd>NoxBrowse<CR>', desc = 'Nox browse' },
    { '<Leader>np', ':<C-u>NoxOgp<Space>', desc = 'Nox OGP' },
    { '<Leader>nb', '<Cmd>NoxBackref<CR>', desc = 'Nox back references' },
    { '<Leader>nm', '<Cmd>NoxMeta<CR>', desc = 'Nox meta information' },
    { '<Leader>nt', '<C-u>/\\[<Space>\\]<CR>', desc = 'Find tasks' },
    -- Open
    { '<Leader>oo', '<Cmd>NoxGo<CR>', ft = 'nox', desc = 'Nox go' },
    { '<Leader>ot', '<Cmd>NoxGo tabedit<CR>', ft = 'nox', desc = 'Nox tabedit open' },
    { '<Leader>ov', '<Cmd>NoxGo vsplit<CR>', ft = 'nox', desc = 'Nox vsplit open' },
    { '<Leader>os', '<Cmd>NoxGo split<CR>', ft = 'nox', desc = 'Nox split open' },
    { '<Leader>oy', '<Cmd>NoxGo "<CR>', ft = 'nox', desc = 'Nox yank the link ' },
    -- Telescope
    { '<Leader>jo', '<Cmd>Telescope nox outline<CR>', ft = 'nox', desc = 'Nox outline' },
    {
      'gf',
      function()
        require('nox.command').open_link_on_cursor('edit', function()
          vim.cmd('normal! gf')
        end)
      end,
      mode = { 'n', desc = '' },
      noremap = true,
      silent = true,
      ft = 'nox',
      desc = 'Nox go',
    },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'tyru/open-browser.vim',
  },
  init = function()
    vim.g.nox_diary_id_base = 'diary/'
    vim.g.nox_use_pre_api = 1

    vim.g.nox_endpoint = 'https://nox.local.anekos.com'
    -- vim.g.nox_endpoint = 'http://localhost:8000'
  end,
  config = function()
    require('telescope').load_extension('nox')
    -- nvim-treesitter/README.md - https://github.com/nvim-treesitter/nvim-treesitter/blob/master/README.md
    vim.treesitter.language.register('markdown', 'nox')
  end,
}
