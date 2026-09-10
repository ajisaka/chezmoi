-- ddc.vim と統合して動作する Vim/Neovim 向け SKK 日本語入力プラグイン。辞書やポップアップ表示を細かく設定できる。
return {
  'vim-skk/skkeleton',
  cond = false,
  evetns = { 'InsertEnter' },
  keys = {
    { '<C-x><Space>', '<Plug>(skkeleton-toggle)', mode = { 'i', 'c' }, desc = 'SKK' },
  },
  dependencies = {
    'vim-denops/denops.vim',
    'NI57721/skkeleton-state-popup',
  },
  config = function()
    vim.fn['skkeleton#config'] {
      globalDictionaries = {
        { '~/.skk/SKK-JISYO.L', 'euc-jp' },
        { '~/.skk/SKK-JISYO.hatena-keyword', 'euc-jp' },
        { '~/.skk/SKK-JISYO.hokuto', 'euc-jp' },
        { '~/.skk/SKK-JISYO.emoji.utf8', 'utf-8' },
      },
    }

    vim.fn['skkeleton_state_popup#config'] {
      labels = {
        input = { hira = 'あ', kata = 'ア', hankata = 'ｶﾅ', zenkaku = 'Ａ' },
        ['input:okurinasi'] = { hira = '▽▽', kata = '▽▽', hankata = '▽▽', abbrev = 'ab' },
        ['input:okuriari'] = { hira = '▽▽', kata = '▽▽', hankata = '▽▽' },
        henkan = { hira = '▼▼', kata = '▼▼', hankata = '▼▼', abbrev = 'ab' },
        latin = '_A',
      },
      opts = { relative = 'cursor', col = 0, row = 1, anchor = 'NW', style = 'minimal' },
    }
    vim.fn['skkeleton_state_popup#run']()
  end,
}
