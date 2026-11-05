-- TOML・hledger・Python・Lua・systemd・SQL など各種ファイルタイプ向けのシンタックス・インデントプラグイン群。
return {
  {
    'cespare/vim-toml',
    ft = 'toml',
  },
  {
    'anekos/hledger-vim',
    ft = 'hledger',
  },
  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
  },
  {
    'raymond-w-ko/vim-lua-indent',
    ft = 'lua',
  },
  {
    'Matt-Deacalion/vim-systemd-syntax',
    event = 'FileType',
  },
  {
    'jsborjesson/vim-uppercase-sql',
    ft = 'sql',
  },
}
