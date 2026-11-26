-- ファイルシステム・バッファ・Git 状態をツリー表示するファイラー。サイドバー・フローティングなどレイアウトを柔軟に設定できる。
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = { 'Neotree' },
  keys = {
    {
      '<Leader>ff',
      '<Cmd>Neotree toggle reveal position=left<CR>',
      mode = { 'n' },
      desc = 'Neo-tree filer',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('neo-tree').setup {
      close_if_last_window = false,
      enable_git_status = true,
      enable_diagnostics = true,
      sources = { 'filesystem', 'buffers', 'git_status' },

      filesystem = {
        filtered_items = {
          visible = false, -- 隠しファイル等も表示(薄く)
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            'node_modules',
            '__pycache__',
            '.aws-sam',
            '.terraform',
            '.mypy_cache',
            '.venv',
            '.git',
          },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = true,
      },

      window = {
        position = 'left',
        width = 36,
        mappings = {
          ['s'] = 'noop',
          ['<CR>'] = 'open',
          ['c'] = 'add',
          ['p'] = { 'toggle_preview', config = { use_float = true, use_snacks_image = true, use_image_nvim = false } },
          ['dd'] = 'delete',
          ['H'] = 'close_node',
          ['L'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' then
              require('neo-tree.sources.filesystem.commands').expand_all_nodes(state, node)
            else
              require('neo-tree.sources.filesystem.commands').open(state)
            end
          end,
          ['='] = 'set_root',
          ['<C-t>'] = 'open_tabnew',
          ['<C-r>'] = 'refresh',
          ['<C-v>'] = 'open_vsplit',
          ['<C-s>'] = 'open_split',
        },
      },
    }
  end,
}
