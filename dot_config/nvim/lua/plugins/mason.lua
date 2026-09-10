-- LSP サーバー・DAP・リンター・フォーマッターを Neovim 内から統一インターフェースでインストール・管理するパッケージマネージャー。
return {
  'williamboman/mason.nvim',
  cmd = {
    'Mason',
    'MasonInstall',
    'MasonUninstall',
    'MasonUninstallAll',
    'MasonLog',
    'MasonInstallForMe',
  },
  config = function()
    require('plugins/shared/mason')
    require('mason').setup()
  end,
}
