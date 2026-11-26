-- 高速で設定しやすい Neovim 用ステータスライン。モード・git・診断情報などのコンポーネントをカスタマイズできる。
return {
  'nvim-lualine/lualine.nvim',

  lazy = false, -- 遅延すると、分割時の表示がおかしくなる

  priority = require('anekos.priority').colors.lualine,

  dependencies = {
    { 'AndreM222/copilot-lualine' },
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename', 'g:anekos_vim_debug' },
      ---
      lualine_x = {
        {
          function()
            local char = vim.fn.matchstr(vim.fn.getline('.'), [[\%]] .. vim.fn.col('.') .. 'c.')
            local code = vim.fn.char2nr(char)
            return string.format('U+%04X', code)
          end,
          cond = function()
            return vim.fn.mode() == 'n'
          end,
        },

        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {
        {
          'copilot',
          symbols = {
            status = {
              icons = {
                enabled = ' ',
                sleep = ' ', -- auto-trigger disabled
                disabled = ' ',
                warning = ' ',
                unknown = ' ',
                -- enabled = 'E',
                -- sleep = 'S', -- auto-trigger disabled
                -- disabled = 'D',
                -- warning = 'W',
                -- unknown = 'U',
              },
              hl = {
                enabled = '#50FA7B',
                sleep = '#AEB7D0',
                disabled = '#6272A4',
                warning = '#FFB86C',
                unknown = '#FF5555',
              },
            },
            spinners = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            spinner_color = '#6272A4',
          },
          show_colors = false,
          show_loading = true,
        },
        'overseer',
      },
      lualine_z = { 'progress', 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
  config = function(_, opts)
    require('lualine').setup(opts)

    local augroup = vim.api.nvim_create_augroup('lualine-syntax-debug', { clear = true })

    vim.api.nvim_create_user_command('DebugSyntax', function()
      local function set_cursor_highlight_to_global()
        local line = vim.fn.line('.')
        local col = vim.fn.col('.')
        local hlID = vim.fn.synID(line, col, 1)
        local hlName = tostring(line)
          .. ','
          .. tostring(col)
          .. ' '
          .. tostring(hlID)
          .. ' '
          .. vim.fn.synIDattr(hlID, 'name')
        vim.g.anekos_vim_debug = hlName
      end

      vim.api.nvim_create_autocmd('CursorMoved', {
        group = augroup,
        pattern = '*',
        callback = set_cursor_highlight_to_global,
      })
    end, {
      nargs = '*',
    })
  end,
}
