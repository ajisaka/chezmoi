function! s:import_env_vars(args)
  let l:register = "*"
  if a:args != ""
    let l:register = a:args
  endif

  let l:lines = split(getreg(l:register), "\n")
  for l:line in l:lines
    let l:parts = matchlist(l:line, '^\([^=]\+\)=\(\S\+\)$')

    if len(l:parts) < 3
      continue
    endif

    let l:name = l:parts[1]
    if matchstr(l:name, '^export .*') != ""
      let l:name = trim(substitute(l:name, '^export ', '', ''))
    else
      let l:name = trim(l:name)
    endif

    let l:value = trim(l:parts[2])
    if l:value[0] == '"' && l:value[-1:] == '"'
      let l:value = l:value[1:-2]
    endif

    call setenv(l:name, l:value)
    echomsg 'Set ' . l:name . ' = "' . l:value[0:5] . '..."'
  endfor
endfunction

command! -nargs=? ImportEnv call s:import_env_vars(<q-args>)
