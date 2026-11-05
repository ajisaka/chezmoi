-- Action / Condition {{{

local is_filetype = function(filetypes)
  return function(ctx)
    for _, ft in ipairs(filetypes) do
      if ctx.filetype == ft then
        return true
      end
    end
    return false
  end
end

local nnoremap = function(entry, _)
  local map = entry.value or ''
  local internal_rep = vim.api.nvim_replace_termcodes(map, true, false, true)
  vim.api.nvim_feedkeys(internal_rep, 'n', false)
end

-- }}}

-- Filter Menu {{{

local function apply_filter_menu()
  local filter_roots = { '~/script/vim/filter' }
  local filters = {}

  for _, root in ipairs(filter_roots) do
    local ok, files = pcall(function()
      return vim.fn.glob(root .. '/*', true, true)
    end)
    if ok then
      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        table.insert(filters, {
          display = name:gsub('-', ' '),
          value = '%! ' .. file,
        })
      end
    end
  end

  return filters
end

-- }}}

-- LLM Filter Menu {{{

local function apply_llm_filter_menu()
  local filter_roots = { '~/script/vim/llm-filter' }
  local filters = {}

  for _, root in ipairs(filter_roots) do
    local ok, files = pcall(function()
      return vim.fn.glob(root .. '/*', true, true)
    end)
    if ok then
      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        local content = vim.fn.readfile(file)
        table.insert(filters, {
          display = name:gsub('-', ' '),
          value = 'LLMFilter ' .. vim.fn.join(content, '\n'),
        })
      end
    end
  end

  return filters
end

-- }}}

-- Liname Filter Menu {{{

local function apply_liname_filter_menu()
  local filter_roots = { '~/script/vim/liname-filter' }
  local filters = {}

  for _, root in ipairs(filter_roots) do
    local ok, files = pcall(function()
      return vim.fn.glob(root .. '/*', true, true)
    end)
    if ok then
      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        table.insert(filters, {
          display = name:gsub('-', ' '),
          value = 'LinameFilter -f ' .. file,
        })
      end
    end
  end

  return filters
end

-- }}}

local filters = apply_filter_menu()
local llm_filters = apply_llm_filter_menu()
local liname_filters = apply_liname_filter_menu()

-- Default Menu {{{

local default_menu = {
  {
    display = 'Auto save',
    value = 'ASToggle',
  },
  {
    display = 'Change colorscheme',
    value = 'Telescope colorscheme',
  },
  {
    display = 'Cross line',
    value = 'setlocal cursorcolumn! cursorline!',
  },
  {
    display = 'Symbols Outline',
    value = 'SymbolsOutline',
  },
  {
    display = 'Nox | Journal',
    value = 'NoxDiary --id=work/grad-cube/journal/',
  },
  {
    display = 'Nox | Journal Weekly',
    value = 'NoxDiary --id=work/grad-cube/journal/weekly',
  },
  {
    display = 'Nox | Weekly Planning',
    value = 'NoxSearch sort:u id=planning/weekly',
  },
  {
    display = 'Nox | Operation Logs',
    value = 'NoxSearch sort:c id=log/operation',
  },
  {
    display = 'Nox | Draft',
    value = 'NoxSearch sort:c id=draft',
  },
  {
    display = 'Nox | Todo Tasks',
    value = '/\\[ \\]',
  },
  {
    display = 'Wishlist',
    value = 'NoxSearch -sort:id id=wishlist -tag:archived',
  },
  {
    display = 'Context',
    value = 'TSContextToggle',
  },
  {
    display = 'Neovim | New plugin',
    value = ':<C-u>edit ~/.config/nvim/lua/plugins/',
    action = nnoremap,
  },
  {
    display = 'Neovim | New task',
    value = ':<C-u>edit ~/.config/nvim/lua/overseer/template/anekos/first_task.lua',
    action = nnoremap,
  },
  {
    display = 'Full screen',
    value = 'lua vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen',
    condition = function()
      return vim.fn.exists('g:neovide')
    end,
  },
  {
    display = 'Toggle LSP Lines',
    value = 'lua require("lsp_lines").toggle',
  },
  {
    display = 'Commit',
    value = 'tab Git ci',
  },
  {
    display = 'Colorizer',
    value = 'ColorizerToggle',
  },
  {
    display = 'Create Shell Script',
    value = 'set ft=sh | Template main | w | Chmod +x',
  },
  {
    display = 'Reset diagnostics',
    value = 'lua vim.diagnostic.reset()',
  },
}

-- }}}

-- Filetype Menu {{{

local filetypes = {
  {
    { 'nox', 'markdown' },
    {
      {
        display = 'Table Mode',
        value = 'TableModeToggle',
      },
      {
        display = 'Reset list number',
        value = 'MDResetListNumber',
      },
    },
  },
}

filetypes.markdown = filetypes.nox

-- }}}

-- Finalize {{{

local compare = function(a, b)
  return a.display:lower() < b.display:lower()
end

local merged = {}

for _, ft_menu in ipairs(filetypes) do
  table.sort(ft_menu[2], compare)
  for _, item in ipairs(ft_menu[2]) do
    item.condition = is_filetype(ft_menu[1])
    table.insert(merged, item)
  end
end

table.sort(default_menu, compare)

for _, item in ipairs(default_menu) do
  table.insert(merged, item)
end

return {
  -- https://github.com/octarect/telescope-menu.nvim
  default = {
    items = merged,
  },
  filter = { items = filters },
  llm = { items = llm_filters },
  liname = { items = liname_filters },
  ai = { items = require('anekos.menu').collected.ai },
}

-- }}}
