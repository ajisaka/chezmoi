-- Misc {{{

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

--  Use the mason bin path for lsp servers installed by mason
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('data') .. '/mason/bin'

-- }}}

-- Global mappings. {{{

-- vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev) -- lspsaga
-- vim.keymap.set('n', 'gn', vim.diagnostic.goto_next) -- lspsaga
-- vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist)
-- vim.keymap.set('n', '<Leader>lr', ':<C-u>IncRename<Space>')
vim.keymap.set('n', '<Leader>lR', '<Cmd>lsp restart<CR>')

vim.keymap.set('n', 'g/', function()
  vim.lsp.buf.hover()
end, { desc = 'LSP hover' })
vim.keymap.set('n', 'g?', function()
  vim.diagnostic.open_float()
end, { desc = 'LSP diagnostic' })

vim.keymap.set('n', '<Leader>lF', function()
  vim.lsp.buf.format()
end, { remap = true })

-- }}}

-- Command {{{

vim.api.nvim_create_user_command('LspStatus', function()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    print('LSP: No clients attached')
    return
  end
  local names = vim.tbl_map(function(c)
    return c.name
  end, clients)
  print('LSP: ' .. table.concat(names, ', '))
end, { desc = 'Show attached LSP clients' })

-- }}}

-- LspAttach {{{

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- lspsaga
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- lspsaga
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- lspsaga
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'LSP information' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'LSP reference' })
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

-- }}}

-- For each languages {{{

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local ensure_installed = {}
vim.g.anekos_conform = {}

-- lspconfig.util.root_pattern の代替。glob (例: '*.cabal') も扱う。
-- fname のあるディレクトリから上方向に探索し、最初に見つかったディレクトリを返す。
local function root_pattern(...)
  local patterns = { ... }
  return function(fname)
    local matcher = function(name)
      for _, pat in ipairs(patterns) do
        if name == pat then
          return true
        end
        if pat:find('*', 1, true) then
          local lua_pat = '^' .. pat:gsub('[%.%-]', '%%%0'):gsub('%*', '.*') .. '$'
          if name:match(lua_pat) then
            return true
          end
        end
      end
      return false
    end
    local found = vim.fs.find(matcher, { upward = true, path = vim.fs.dirname(fname) })[1]
    return found and vim.fs.dirname(found) or nil
  end
end

local function use_lsp(lsp_name, package_name, enabled)
  return function(config)
    if enabled == false then
      return
    end
    table.insert(ensure_installed, package_name or lsp_name)
    vim.lsp.config[lsp_name] = config
    vim.lsp.enable(lsp_name)
  end
end

local function use_fmt(name, enabled)
  return function(config)
    if enabled == false then
      return
    end
    table.insert(ensure_installed, name)
    if not vim.tbl_isempty(config) then
      vim.g.anekos_conform = vim.tbl_deep_extend('force', vim.g.anekos_conform, config)
    end
  end
end

vim.api.nvim_create_user_command('MasonInstallForMe', function()
  for _, pkg in ipairs(ensure_installed) do
    vim.cmd('MasonInstall ' .. pkg)
  end
end, {})

-- autoflake
-- black
-- checkmake
-- elm-language-server
-- gopls
-- html-lsp
-- hyprls
-- isort
-- mypy
-- nil
-- nixfmt
-- openscad-lsp
-- yaml-language-server

use_fmt('stylua', true) {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
  formatters = {
    stylua = {
      append_args = {
        '--column-width',
        '120',
        '--line-endings',
        'Unix',
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--quote-style',
        'AutoPreferSingle',
        '--call-parentheses',
        'NoSingleTable',
        '--collapse-simple-statement',
        'Never',
      },
    },
  },
}

use_fmt('taplo', true) {
  formatters_by_ft = {
    toml = { 'taplo' },
  },
}

use_lsp('bashls', 'bash-language-server', true) {
  cmd = { 'bash-language-server', 'start' },
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
  filetypes = { 'bash', 'sh' },
  root_markers = { '.git' },
}

use_lsp('gopls', nil, true) {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work' },
}

-- ghcup が必要
use_lsp('hls', 'haskell-language-server', true) {
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  filetypes = { 'haskell', 'lhaskell' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(root_pattern('hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml')(fname))
  end,
  settings = {
    haskell = {
      formattingProvider = 'ormolu',
      cabalFormattingProvider = 'cabal-fmt',
    },
  },
}

use_lsp('json_lsp', 'json-lsp', true) {
  cmd = function(dispatchers, config)
    local cmd = 'vscode-json-language-server'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
  end,
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}

use_lsp('lua_ls', 'lua-language-server', true) {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.git',
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      format = {
        enable = false,
      },
    },
  },
}

use_lsp('pylsp', 'python-lsp-server', true) {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
}

use_lsp('ruff', nil, true) {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    '.git',
  },
  on_attach = function(client, _)
    -- hover は pylsp に任せる
    client.server_capabilities.hoverProvider = false
  end,
}

-- See ~/.config/nvim/lua/plugins/scala-metals.lua
-- use_lsp('metals', nil, true) {
--   cmd = { 'metals' },
--   filetypes = { 'scala' },
--   root_markers = { 'build.sbt', 'build.sc', { 'build.gradle', 'build.gradle.kts' }, 'pom.xml' },
--   init_options = {
--     statusBarProvider = 'show-message',
--     isHttpEnabled = true,
--     compilerOptions = {
--       snippetAutoIndent = false,
--     },
--   },
--   capabilities = {
--     workspace = {
--       configuration = false,
--     },
--   },
-- }

use_lsp('taplo', nil, true) {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
}

use_lsp('terraformls', 'terraform-ls', false) {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
}

-- }}}
