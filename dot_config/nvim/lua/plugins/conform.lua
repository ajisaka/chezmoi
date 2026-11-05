-- extmarks・折りたたみ・カーソル位置を保持しながらコードフォーマッターを実行する軽量フォーマッタープラグイン。
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'VeryLazy' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>lF',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  -- https://github.com/stevearc/conform.nvim#formatters or `:help conform-formatters`
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function()
    -- See: ~/.config/nvim/part/40-lsp.lua
    local opts = vim.tbl_deep_extend('force', vim.g.anekos_conform or {}, {
      formatters_by_ft = {
        terraform = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        python = { 'ruff_organize_imports', 'ruff_format' },
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = function(bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)
        if path:match('%.tmpl$') then
          return nil
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters = {
        shfmt = {
          append_args = { '-i', '2' },
        },
      },
    })
    -- print('conform: initializing', vim.inspect(opts))
    require('conform').setup(opts)
  end,
}
