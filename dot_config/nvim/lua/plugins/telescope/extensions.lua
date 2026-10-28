local plugins = {
  changes = 'LinArcX/telescope-changes.nvim',
  env = 'LinArcX/telescope-env.nvim',
  find_pickers = 'keyvchan/telescope-find-pickers.nvim',
  -- frecency = 'nvim-telescope/telescope-frecency.nvim',
  git_diffs = 'paopaol/telescope-git-diffs.nvim',
  import = 'piersolenski/telescope-import.nvim',
  lazy = 'tsakirist/telescope-lazy.nvim',
  undo = 'debugloop/telescope-undo.nvim',
  keyboard_mapping = 'anekos/telescope-keyboard-mapping',
  symbols = 'nvim-telescope/telescope-symbols.nvim',
  neoclip = {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup {
        enable_persistent_history = true,
      }
    end,
    dependencies = { 'kkharji/sqlite.lua' },
  },
  sonictemplate = { -- {{{
    -- 'tamago324/telescope-sonictemplate.nvim',
    'anekos/telescope-sonictemplate.nvim',
    dependencies = { 'mattn/vim-sonictemplate' },
  }, -- }}}
  -- media_files = 'nvim-telescope/telescope-media-files.nvim',
  yank_history = {
    'gbprod/yanky.nvim',
    opts = {},
  },
  fzf = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  -- My Plugins
  -- session = 'anekos/telescope-session',
  zoxide = {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  quickrun = 'anekos/telescope-quickrun',
  aws = 'anekos/telescope-aws',
  zsh = { -- {{{
    'anekos/telescope-zsh',
    opts = {
      history_file = '~/buffer/home/.zsh_history',
    },
  }, -- }}}
  rg = { -- {{{
    'anekos/telescope-rg',
    cmd = { 'Rg' },
  }, -- }}}
  menu = {
    'anekos/telescope-menu.nvim', -- forked
    branch = 'feature/menu-item-condition',
  },
  -- }}}
}

-- Build {{{

local load_after = {}

local exts = {}

exts.dependencies = {
  -- 'nvim-lua/plenary.nvim',
  -- {
  --   'prochri/telescope-all-recent.nvim',
  --   dependencies = {
  --     'kkharji/sqlite.lua',
  --     'stevearc/dressing.nvim',
  --   },
  --   opts = {},
  -- },
}

exts.cmd = {
  'Telescope',
}

for _, repo in pairs(plugins) do
  table.insert(exts.dependencies, repo)
  if repo.cmd then
    for _, cmd in pairs(repo.cmd) do
      table.insert(exts.cmd, cmd)
    end
  end
end

local try_to_load = function(name, retry)
  local ok, _ = pcall(function()
    return require('telescope').load_extension(name)
  end)
  if not ok and retry then
    table.insert(load_after, name)
  end
  return ok
end

-- vim.api.nvim_create_autocmd(
--   'UIEnter',
--   {
--     callback = function ()
--       for _, name in pairs(load_after) do
--         if not try_to_load(name, false) then
--           print('Failed to load (UIEnter): ' .. name)
--         end
--       end
--     end
--   }
-- )

function exts.load()
  for name, _ in pairs(plugins) do
    try_to_load(name, true)
  end
end

-- }}}

return exts
