function s:main()
  if getline(1) != ''
    return
  endif

  let l:branch_name = system('git rev-parse --abbrev-ref HEAD')
  let l:leaf = substitute(l:branch_name, '.*\/', '', '')

  " Prefixed with numbers
  if l:leaf =~ '^\d\+'
    let l:numbers = substitute(l:leaf, '-.*', '', '')
    echo l:numbers
    call append(0, 'Closes #' . l:numbers . ': ')

    " Move to first line
    normal! gg
  endif
endfunction

call s:main()
