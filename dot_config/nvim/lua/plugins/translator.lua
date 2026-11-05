-- 複数の翻訳エンジンに対応した非同期翻訳プラグイン。ポップアップ・プレビュー・翻訳結果の挿入が可能。
return {
  'voldikss/vim-translator',
  cmd = {
    'Translate',
    'TranslateR',
    'TranslateX',
    'TranslateH',
    'TranslateL',
    'TranslateW',
  },
  keys = {
    { '<Leader>y', ':TranslateW<CR>', mode = { 'v', 'n' }, silent = true, desc = 'Translate in window' },
    { '<Leader>Y', ':TranslateR<CR>', mode = { 'v', 'n' }, silent = true, desc = 'Translate and replace' },
  },
  init = function()
    vim.g.translator_default_engines = { 'google' }
    vim.g.translator_history_enable = true
    vim.g.translator_source_lang = 'auto'
    vim.g.translator_target_lang = 'ja'
    vim.g.translator_window_max_height = 0.8
    vim.g.translator_window_max_width = 0.95
    vim.g.translator_window_type = 'popup' -- `popup` or `preview`
  end,
}
