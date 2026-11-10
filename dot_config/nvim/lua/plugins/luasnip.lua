-- LSP・VSCode・SnipMate 形式に対応した高機能スニペットエンジン。動的・条件付きノードによる複雑なスニペットも定義可能。

local clipreg = '+'

local define = function(ls)
  -- Nodes {{{
  local snip = ls.snippet
  local text = ls.text_node
  local insert = ls.insert_node
  local fun = ls.function_node
  -- local indent = ls.indent_snippet_node
  -- }}}

  -- Utils {{{

  local split = function(s)
    if type(s) == 'string' then
      return vim.split(s, '\n')
    end
    return s
  end

  local simple1 = function(trig, content)
    local body

    if type(content) == 'string' then
      body = text(content)
    elseif type(content) == 'function' then
      body = fun(function()
        return split(content())
      end)
    else
      body = content
    end

    return snip({
      trig = trig,
    }, {
      body,
      insert(0),
    })
  end

  local date = function(trig, fmt)
    return simple1(trig, function()
      return os.date(fmt)
    end)
  end

  local vimfn = function(trig, fname, args)
    return simple1(trig, function()
      return vim.fn[fname](unpack(args))
    end)
  end

  local fetch = function(trig, fmt, summary)
    return snip({ trig = trig }, {
      fun(function()
        return split(vim.trim(vim.fn['web_fetcher#markdown'](fmt, vim.trim(vim.fn.getreg(clipreg)), summary)))
      end),
      insert(0),
    })
  end

  -- }}}

  local nox = { --- {{{
    fetch('noxa', 'markdown-link', false),
    fetch('noxdl', 'markdown-definition-list', false),
    fetch('noxh', 'markdown-heading', false),
    fetch('noxhi', 'markdown-heading', false),
    fetch('noxhc', 'markdown-heading-content', false),
    fetch('noxhq', 'markdown-heading-quoted', false),
    fetch('noxli', 'markdown-list', false),
    fetch('noxsdl', 'markdown-definition-list', true),
    fetch('noxsh', 'markdown-heading', true),
    fetch('noxshi', 'markdown-heading', true),
    fetch('noxshc', 'markdown-heading-content', true),
    fetch('noxshq', 'markdown-heading-quoted', true),
    fetch('noxsli', 'markdown-list', true),
  } -- }}}

  ls.add_snippets(nil, {
    all = { -- {{{
      date('today', '%Y-%m-%d'),
      date('todays', '%Y/%m/%d'),
      date('now', '%Y-%m-%d %H:%M:%S'),
      date('noww', '%Y-%m-%d (%a) %H:%M:%S'),
      date('nows', '%Y/%m/%d %H:%M:%S'),
      date('nowsw', '%Y/%m/%d (%a) %H:%M:%S'),
      vimfn('uuid', 'system', { [[python -c "import uuid, sys; sys.stdout.write(str(uuid.uuid4()))"]] }),
      simple1('fmtdate', '%Y-%m-%d'),
      simple1('fmtdatetime', '%Y-%m-%dT%H:%M:%S'),
      vimfn('clip', 'getreg', { clipreg }),
      snip({
        trig = 'clip/join',
      }, {
        fun(function()
          return vim.fn.join(vim.fn.split(vim.fn.getreg(clipreg), '\n'), ', ')
        end),
      }),
      snip({
        trig = 'clip/list',
      }, {
        fun(function()
          return vim.tbl_map(function(it)
            return '- ' .. it
          end, vim.fn.split(vim.fn.getreg(clipreg), '\n'))
        end),
      }),
      snip({
        trig = 'mdimg',
      }, {
        text('!['),
        insert(1, 'Image'),
        text(']('),
        fun(function()
          return vim.fn.getreg(clipreg)
        end),
        text(')'),
        insert(0),
      }),
      snip({
        trig = 'mdlink',
      }, {
        text('['),
        insert(1, 'Title'),
        text(']('),
        fun(function()
          return vim.fn.getreg(clipreg)
        end),
        text(')'),
        insert(0),
      }),
    }, -- }}}
    lua = { -- {{{
      snip({ trig = 'strings' }, {
        fun(function()
          local result = { '{' }
          for _, v in ipairs(vim.split(vim.fn.getreg(clipreg), '\n')) do
            table.insert(result, '  [[' .. v .. ']],')
          end
          table.insert(result, '}')
          return result
        end),
        insert(0),
      }),
      simple1(
        'feedkeys',
        text {
          [[local key = vim.api.nvim_replace_termcodes('<esc>', true, false, true)]],
          [[vim.api.nvim_feedkeys(keys, 'n', true)]],
        }
      ),
    }, -- }}}
    nox = nox,
    markdown = nox,
  })
end

-- {{{

return {
  version = 'v2.3.0',
  'L3MON4D3/LuaSnip',
  build = 'make install_jsregexp',
  event = 'InsertEnter',
  config = function()
    local ls = require('luasnip')
    ls.setup {}

    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#snippet_syntax
    require('luasnip.loaders.from_vscode').lazy_load { paths = '~/friendly-snippets/' }
    require('luasnip.loaders.from_snipmate').lazy_load { paths = { vim.fn.stdpath('config') .. '/snippet/snipmate' } }

    vim.keymap.set({ 'i' }, '<C-s>', function()
      ls.expand()
    end, { silent = true })

    vim.keymap.set({ 't' }, '<C-x><C-x>', function()
      ls.expand()
    end, { silent = true })

    vim.keymap.set({ 's', 'i' }, '<Tab>', function()
      if ls.jumpable(1) then
        local keys = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', true)
        ls.jump(1)
      else
        local keys = vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', true)
      end
    end, { silent = true })

    define(ls)
  end,
}

-- }}}
