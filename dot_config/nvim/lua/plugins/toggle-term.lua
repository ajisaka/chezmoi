-- 複数の永続ターミナルをフローティング・垂直分割・タブなどのレイアウトでトグル表示する。
return {
  'akinsho/toggleterm.nvim',
  keys = {
    { '<C-\\><C-\\>', ':ToggleTerm<CR>',        mode = { 'n', 'i' }, desc = 'Toggle terminal' },
    { '<C-\\>x',      ':ToggleTermExec<Space>', mode = { 'n' },      desc = 'Send toggled terminal' },
  },
  cmd = {
    'ToggleTerm',
  },
  config = function()
    vim.api.nvim_create_user_command('ToggleTermExec', function(opts)
      require('toggleterm').exec(opts.args)
    end, {
      nargs = '*',
    })

    local function width()
      return math.floor(vim.o.columns / 5 * 2)
    end
    local function height()
      return math.floor(vim.o.lines / 5 * 2)
    end
    local function col()
      return vim.o.columns - width() - 1
    end

    local function row()
      return vim.o.lines - height() - 4
    end

    require('toggleterm').setup {
      open_mapping = [[<C-\><C-\>]],
      -- direction = 'vertical',
      direction = 'float',

      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,

      float_opts = {
        border = 'curved',
        width = width,
        height = height,
        winblend = 30,
        row = row,
        col = col,
        highlights = {
          border = 'Normal',
        },
      },

      on_create = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-S-v>', '<C-\\><C-n>p', { noremap = true })
      end,
    }
  end,
}
