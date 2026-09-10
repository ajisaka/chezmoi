-- カーソル下の URL またはキーワードをブラウザで開くか、検索エンジンで検索する。複数の検索エンジンに対応。
return {
  'tyru/open-browser.vim',
  keys = {
    { '<Leader>O', '<Plug>(openbrowser-smart-search)', mode = { 'n', 'x', 'v' }, remap = true, desc = 'Open browser' },
  },
  init = function()
    vim.g.openbrowser_browser_commands = {
      {
        name = 'xdg-open',
        args = { 'xdg-open', '{uri}' },
      },
      {
        name = 'open',
        args = { 'open', '{uri}' },
      },
      {
        name = 'w3m',
        args = { 'w3m', '{uri}' },
      },
    }

    -- vim.g.netrw_nogx = 1  -- disable netrw's gx mapping.

    vim.g.openbrowser_search_engines = {
      alc = 'https://eow.alc.co.jp/search?q={query}',
      askubuntu = 'https://askubuntu.com/search?q={query}',
      baidu = 'https://www.baidu.com/s?wd={query}&rsv_bp=0&rsv_spt=3&inputT=2478',
      cpan = 'http://search.cpan.org/search?query={query}',
      devdocs = 'https://devdocs.io/#q={query}',
      duckduckgo = 'https://duckduckgo.com/?q={query}',
      go = 'https://pkg.go.dev/search?q={query}',
      fileformat = 'https://www.fileformat.info/info/unicode/char/{query}/',
      github = 'https://github.com/search?q={query}',
      google = 'https://google.com/search?q={query}',
      php = 'https://php.net/{query}',
      python = 'https://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
      twitter_search = 'https://twitter.com/search/{query}',
      twitter_user = 'https://twitter.com/{query}',
      vim = 'https://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
      wikipedia = 'https://en.wikipedia.org/wiki/{query}',
      wikipedia_ja = 'https://ja.wikipedia.org/wiki/{query}',
      yahoo = 'https://search.yahoo.com/search?p={query}',
      kagi = 'https://kagi.com/search?q={query}',
    }

    vim.g.openbrowser_default_search = 'kagi'
  end,
}
