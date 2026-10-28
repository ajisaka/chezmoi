-- LSP・スニペット・パスなど多様なソースからの補完を提供する Lua 製補完エンジン。
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    'saadparwaiz1/cmp_luasnip',
    'lukas-reineke/cmp-under-comparator',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    { 'zbirenbaum/copilot-cmp', opts = {} },

    -- The below 2 plugins are couple
    -- https://github.com/luckasRanarison/tailwind-tools.nvim?tab=readme-ov-file#utilities
    -- 'luckasRanarison/tailwind-tools.nvim',
    'onsails/lspkind-nvim',
    'anekos/hledger-vim',
    -- Disabled
    -- 'ray-x/cmp-treesitter',
  },
  config = function()
    local cmp = require('cmp')

    -- require('cmp').register_source('nyai_parameter', require('nyai.cmp').new())

    require('cmp').register_source('nyai_parameter', require('nyai.cmp.parameter').new())
    require('cmp').register_source('nyai_completion', require('nyai.cmp.completion').new())

    local primary_sources = {
      { name = 'nyai_completion' },
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'emoji',                  insert = true },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = 'calc' },
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
      -- { name = 'treesitter' },
    }

    if vim.env['GITHUB_COPILOT_TOKEN'] ~= nil then
      table.insert(primary_sources, { name = 'copilot' })
    end

    cmp.setup {
      enabled = function()
        return true
      end,

      -- formatting = {
      --   format = require('lspkind').cmp_format {
      --     before = require('tailwind-tools.cmp').lspkind_format,
      --   },
      -- },

      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,

      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },

      sources = cmp.config.sources(primary_sources, {
        -- Secondary sources
      }),

      -- mapping = cmp.mapping.preset.insert({
      --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
      --   ['<C-Space>'] = cmp.mapping.complete(),
      --   ['<C-e>'] = cmp.mapping.abort(),
      --   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      -- }),

      mapping = {
        ['<C-n>'] = {
          i = cmp.mapping.select_next_item(),
        },
        ['<C-p>'] = {
          i = cmp.mapping.select_prev_item(),
        },
        ['<C-c>'] = {
          i = cmp.mapping.close(),
        },
        ['<CR>'] = {
          i = cmp.mapping.confirm { select = false },
        },
        ['<C-x><C-o>'] = {
          i = cmp.mapping.complete(),
        },
        -- ['<C-e>'] = {
        --   i = cmp.mapping.confirm { select = false },
        -- },
      },

      -- sorting = {
      --   comparators = {
      --     cmp.config.compare.offset,
      --     cmp.config.compare.exact,
      --     cmp.config.compare.score,
      --     require('cmp-under-comparator').under,
      --     cmp.config.compare.kind,
      --     cmp.config.compare.sort_text,
      --     cmp.config.compare.length,
      --     cmp.config.compare.order,
      --   },
      -- },
    }

    cmp.setup.filetype('TelescopePrompt', {
      completion = { autocomplete = nil },
      sources = {},
    })

    cmp.setup.filetype('nyai', {
      completion = { autocomplete = nil },
      sources = {
        { name = 'nyai_parameter' },
      },
    })

    cmp.setup.filetype('hledger', {
      sources = { { name = 'hledger' } },
      sorting = {
        comparators = {
          cmp.config.compare.sort_text,
        },
      },
    })

    -- cmp.setup.filetype('nyai', {
    --   sources = cmp.config.sources({ { name = 'nyai' } }, primary_sources),
    -- })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'calc' },
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!', 'NoxRename', 'NoxOpen' },
          },
        },
      }, {}),
    })

    for prefix in ipairs { '/', '?' } do
      cmp.setup.cmdline(prefix, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
    end
  end,
}
