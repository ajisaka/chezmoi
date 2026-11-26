-- 高速でインタラクティブなファジーファインダー。ファイル・バッファ・grep・LSP シンボルなど多くのソースを検索できる。
local extensions = require('plugins/telescope/extensions')

-- Keys {{{

local keys = {
  { '<Space>', '<Cmd>Telescope md_render find_files<CR>', desc = 'Find files' },

  { '<Leader>b', '<Cmd>Telescope md_render buffers<CR>', desc = 'Buffers' },
  { '<Leader>J', ':<C-u>Telescope<Space>', desc = 'Telescope ...' },

  { '<Leader>ia', '<Cmd>Telescope menu ai<CR>', desc = 'AI' },
  { '<Leader>if', '<Cmd>Telescope menu filter<CR>', desc = 'Filters menu' },
  { '<Leader>il', '<Cmd>Telescope menu llm<CR>', desc = 'LLM Filters menu' },
  { '<Leader>iL', '<Cmd>Telescope menu liname<CR>', desc = 'LiName Filters menu' },
  { '<Leader>ii', '<Cmd>Telescope menu<CR>', desc = 'Miscellaneous menu' },
  { '<Leader>iI', '<Cmd>Telescope menu filetype<CR>', desc = 'File type menu' },

  { '<Leader>ja', '<Cmd>Telescope rg<CR>', desc = 'Rip Grep' },
  { '<Leader>jb', '<Cmd>Telescope buffers<CR>', desc = 'Buffers' },
  { '<Leader>jd', '<Cmd>Telescope zoxide list<CR>', desc = 'Recent directories' },
  { '<Leader>jg', '<Cmd>Telescope live_grep<CR>', desc = 'Live grep' },
  { '<Leader>ji', '<Cmd>Telescope import<CR>', desc = 'Import something' },
  { '<Leader>jj', '<Cmd>Telescope find_pickers<CR>', desc = 'Telescope pickers' },
  { '<Leader>jl', '<Cmd>Telescope lazy<CR>', desc = 'Lazy plugins' },
  { '<Leader>jL', '<Cmd>Telescope locate<CR>', desc = 'Locate' },
  { '<Leader>jm', '<Cmd>Telescope oldfiles<CR>', desc = 'Old files' },
  { '<Leader>jo', '<Cmd>Telescope aerial<CR>', desc = 'Aerial' },
  { '<Leader>jr', '<Cmd>Telescope resume<CR>', desc = 'Resume telescope' },
  { '<Leader>js', '<Cmd>Telescope achoo<CR>', desc = 'Achoo sessions' },
  { '<Leader>jS', '<Cmd>Telescope find_files cwd=~/.config/nvim<CR>', desc = 'Neovim files' },
  { '<Leader>jt', '<Cmd>Telescope sonictemplate templates<CR>', desc = 'Sonic templates' },
  { '<Leader>jy', '<Cmd>Telescope neoclip<CR>', desc = 'Neoclip' },
  { '<Leader>jY', '<Cmd>Telescope yank_history<CR>', desc = 'Yank history' },
  { '<Leader>jz', '<Cmd>Telescope zsh<CR>', desc = 'Zsh history' },

  { '<Leader>ld', '<Cmd>Telescope diagnostics<CR>', desc = 'LSP diagnostics', mode = { 'v', 'n' } },
  { '<Leader>lm', '<Cmd>Telescope import<CR>', desc = 'Insert import', mode = { 'v', 'n' } },
}

-- }}}

-- Mappings {{{

local local_mappings = function()
  local actions = require('telescope.actions')

  local yank = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local entry = require('telescope.actions.state').get_selected_entry()
    vim.fn.setreg('"', vim.inspect(entry.value))
    vim.fn.setreg('*', vim.inspect(entry.value))
    vim.notify('Yanked: ' .. vim.inspect(entry.value))
  end

  return {
    i = {
      ['<C-c>'] = actions.close,
      ['<C-y>'] = yank,
      ['<C-u>'] = false, -- As default, scroll up preview
    },
    n = {
      ['<C-c>'] = actions.close,
      ['<C-g>'] = actions.close,
      ['q'] = actions.close,
      ['y'] = yank,
    },
  }
end

-- }}}

-- switch or open {{{

local function try_to_switch_buffer(name)
  name = vim.fn.expand(name)
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if buf.listed == 1 and buf.hidden == 0 and buf.name ~= '' and 0 < #buf.windows then
      if buf.name == name then
        vim.fn.win_gotoid(buf.windows[1])
        return true
      end
      -- vim.fn.win_gotoid(buf.windows[1])
      -- print(vim.inspect(buf.name))
      -- print(vim.inspect(buf))
    end
  end
  return false
end

local function switch_or_open(name)
  if not try_to_switch_buffer(name) then
    vim.cmd { cmd = 'edit', args = { name } }
  end
end

local function switch_or_open_action(prompt_bufnr)
  require('telescope.actions').close(prompt_bufnr)
  local action_state = require('telescope.actions.state')
  local curr_entry = action_state.get_selected_entry()
  switch_or_open(vim.fn.expand(curr_entry.path))
end

local function open_help(prompt_bufnr)
  require('telescope.actions').close(prompt_bufnr)
  local action_state = require('telescope.actions.state')
  local curr_entry = action_state.get_selected_entry()
  local help_tag = curr_entry.value
  help_tag = help_tag:gsub('@.*', '')
  require('dynamic_help').float_help(help_tag)
end

-- }}}

-- Config {{{

local config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  local path_display = function(_, path)
    path = vim.fn.fnamemodify(path, ':~:.')
    path = vim.fn.substitute(path, [[^\~/my/env/public/home]], '~', '')
    return path
  end

  telescope.setup {
    pickers = {
      buffers = {
        mappings = {
          n = {
            ['dd'] = actions.delete_buffer + actions.move_to_top,
            ['<CR>'] = switch_or_open_action,
            ['<C-e>'] = actions.file_edit,
          },
          i = {
            ['<CR>'] = switch_or_open_action,
            ['<C-e>'] = actions.file_edit,
          },
        },
      },
      colorscheme = {
        enable_preview = true,
      },
      help_tags = {
        mappings = {
          n = {
            ['<CR>'] = open_help,
          },
          i = {
            ['<CR>'] = open_help,
          },
        },
      },
      find_files = {
        find_command = { 'puls' },
      },
    },
    defaults = {
      mappings = local_mappings(),
      file_ignore_patterns = {
        'node_modules',
        'vendor',
        '__pycache__',
        'autoload/vital',
      },
      layout_strategy = 'bottom_pane',
      sorting_strategy = 'ascending',
      layout_config = {
        height = 0.8,
        preview_cutoff = 120,
        prompt_position = 'top',
      },
      path_display = path_display,
    },
    extensions = {
      menu = require('plugins/telescope/menu'),
      lazy = require('plugins/telescope/lazy'),
      media_files = {
        filetypes = { 'png', 'jpg', 'mp4', 'webm', 'pdf' },
        find_cmd = 'rg',
      },
      frecency = {
        -- Correct ??
        auto_validate = false,
      },
      fzf = {
        fuzzy = false, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      zoxide = {
        list_command = 'zoxide query --list --score --all',
        prompt_title = 'zoxide',
        mappings = {
          default = {
            after_action = function(selection)
              print('Update to (' .. selection.z_score .. ') ' .. selection.path)
            end,
          },
          ['<C-s>'] = {
            before_action = function()
              print('before C-s')
            end,
            action = function(selection)
              vim.cmd.edit(selection.path)
            end,
          },
          ['<C-q>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command('split') },
        },
      },
    },
  }

  extensions.load()
end

-- }}}

-- Main {{{

return {
  'nvim-telescope/telescope.nvim',
  cmd = extensions.cmd,
  keys = keys,
  dependencies = extensions.dependencies,
  config = config,
}

-- }}}
