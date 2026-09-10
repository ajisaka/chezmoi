-- Neovim の Lua 設定を書く際に LuaLS のワークスペースライブラリを自動設定し、補完・型チェックを強化する。
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
    },
  },
  dependencies = {
    'Bilal2453/luvit-meta',
  },
}
