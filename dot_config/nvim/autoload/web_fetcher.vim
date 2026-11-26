function! web_fetcher#markdown(type, url, summary)
  let l:base = 'xfetch fetch --format ' . a:type
  if a:summary == v:true
    let l:base .= ' --summary'
  endif
  return system(base . ' ' . shellescape(a:url))
endfunction
