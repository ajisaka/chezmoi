-- 現在のバッファや選択範囲のコードをその場で実行して結果を表示する。多言語対応で設定を柔軟にカスタマイズできる。
local quickrun = function()
  if vim.g.telescope_quickrun_last == nil then
    vim.cmd('QuickRun')
  else
    vim.cmd('QuickRun ' .. vim.g.telescope_quickrun_last)
  end
end

return {
  'thinca/vim-quickrun',
  cmd = 'QuickRun',
  keys = {
    { '<Leader>qq', quickrun, mode = { 'n' }, desc = 'Quick run' },
    { '<Leader>qr', '<Cmd>Telescope quickrun<CR>', mode = { 'n' }, desc = 'Quick run menu' },
  },
  dependencies = {
    'lambdalisue/vim-quickrun-neovim-job',
  },
  init = function()
    vim.g.quickrun_config = {
      ['_'] = {
        ['runner'] = 'neovim_job', -- 'job'
        ['hook/nuko/enable'] = 0,
        ['hook/nuko/wait'] = 2,
        ['hook/lightline_quickrun_status/enable'] = 1,
        ['outputter'] = 'multi',
        ['outputter/buffer_legacy/split'] = 'vertical rightbelow',
        ['outputter/buffer_legacy/close_on_empty'] = 1,
        ['outputter/buffer_legacy/running_mark'] = ' ____________________\n< ﾐｮﾐｮﾐｮﾐｮﾐｮﾐｮﾐｮﾐｮﾐｮ >\n --------------------\n        \\   ^__^\n         \\ (◕‿‿◕)\\_______\n           /(__)\\       )\\/\\\n             || ||----w |\n                ||     ||',
        ['outputter/quickfix/open_cmd'] = '',
        ['outputter/multi/targets'] = { 'buffer_legacy', 'quickfix' },
      },
      ['python'] = {
        exec = 'vpython -u %s',
      },
      ['python/mypy'] = {
        exec = 'vmypy %s',
      },
      ['python/pre-commiit'] = {
        exec = 'rye run pre-commit run --all-files',
      },
    }
  end,
}
