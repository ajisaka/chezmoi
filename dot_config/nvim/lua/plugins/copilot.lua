-- GitHub Copilot の AI コード補完をインライン（ghost text）で提供する Lua 製軽量実装。
return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cond = true, -- vim.env['GITHUB_COPILOT_TOKEN'] ~= nil,
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = true,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
        ['*'] = true,
      },
    }
  end,
}
