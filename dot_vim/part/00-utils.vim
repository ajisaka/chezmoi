"========================
" |\__   /|\ |  |\  |
" |   \   |  |  | \ | /|
" |    |  |  |  |   |/ |
" |    |  |  |  |      |
"========================

scriptencoding utf8


" Generate 1 to n
function! Rand(n)
  " http://vim-jp.org/vim-users-jp/2009/11/05/Hack-98.html
  let l:match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
  return reltimestr(reltime())[l:match_end : ] % (a:n + 1)
endfunction

" Big Sky :: vimでスクリプト内関数を書き換える http://mattn.kaoriya.net/software/vim/20090826003359.htm
function! GetScriptId(filename)
  let l:scriptnames = ''

  redir => l:scriptnames
  silent! scriptnames
  redir END

  let l:script_table = {}
  let l:head = '^\s*\(\d\+\):\s*\(.*\)$'
  for l:line in split(l:scriptnames, "\n")
    let l:script_table[tolower(substitute(l:line, l:head, '\2', ''))] = substitute(l:line, l:head, '\1', '')
  endfor

  return l:script_table[tolower(a:filename)]
endfunction

function! VisualSelection()
  try
    let a_save = @a
    silent! normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

" Vimでパーセントエンコードするときに使える encodeURI()/encodeURIComponent() - くふんを狙え(vimグループ) - vimグループ - http://vim.g.hatena.ne.jp/eclipse-a/20080707/1215395816
function! s:char2hex(c)
  if a:c =~# '^[:cntrl:]$' | return '' | endif
  let r = ''
  for i in range(strlen(a:c))
    let r .= printf('%%%02X', char2nr(a:c[i]))
  endfor
  return r
endfunction

function! EncodeURI(s)
  return substitute(a:s, '[^0-9A-Za-z-._~!''()*#$&+,/:;=?@]',
        \ '\=s:char2hex(submatch(0))', 'g')
endfunction

function! EncodeURIComponent(s)
  return substitute(a:s, '[^0-9A-Za-z-._~!''()*]',
        \ '\=s:char2hex(submatch(0))', 'g')
endfunction

" 選択範囲を返すよ
function! GetSelectedText() abort
  let l:start_line = line("'<")
  let l:end_line = line("'>")
  let l:start_col = col("'<")
  let l:end_col = col("'>")

  if l:start_line == l:end_line
    let l:line = getline(l:start_line)
    echomsg l:start_col
    echomsg l:end_col
    return strpart(l:line, l:start_col - 1, l:end_col - l:start_col + 1)
  endif

  let l:text = strpart(getline(l:start_line), l:start_col - 1) . "\n"
  for l:line in range(l:start_line + 1, l:end_line - 1)
    let l:text .= getline(l:line) . "\n"
  endfor
  let l:text .= strpart(getline(l:end_line), 0, l:end_col)

  return l:text
endfunction
