source ~/.config/nvim/after/ftplugin/markdown.vim

function s:NextWeek()
  let l:current_date = split(bufname('%'), '/')[-1]
  let l:old_date = trim(system('date -d "' . l:current_date . ' -7 days" +%Y-%m-%d'))
  let l:old_id = 'nox://planning/weekly/' . l:old_date

  let l:old_bufnr = bufnr(l:old_id)

  let l:new_lines = []
  let l:rest_lines = []
  let l:in_header = 1
  let l:in_undone = 0

  for l:old_line in getbufline(l:old_bufnr, 1, '$')
    if l:in_header == 1
      if l:old_line == ""
        let l:in_header = 0
      endif
      continue
    endif

    if l:in_undone == 1 && l:old_line =~# '^  '
      call add(l:new_lines, l:old_line)
      continue
    else
      let l:in_undone = 0
    endif

    if l:old_line =~# '^#' || l:old_line == ''
      call add(l:new_lines, l:old_line)
      call add(l:rest_lines, l:old_line)
      continue
    endif

    if l:old_line =~# '^- \[ \]'
      let l:in_undone = 1
      call add(l:new_lines, l:old_line)
      continue
    endif

    call add(l:rest_lines, l:old_line)
  endfor

  call append('$', l:new_lines)
  call deletebufline(l:old_bufnr, 5, '$')
  call setbufline(l:old_bufnr, '$', l:rest_lines)
endfunction

command! NextWeek call s:NextWeek()
