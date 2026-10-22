"=============================================
"                         /
" |\   |\__   /|\ |\      |     |\  /| |\  /|
" |\ \ |   \   |  |\ \/  /\     | /\ | | \/ |
" |  \ |    |  |  | \/  |   \   |/  \| | /\ |
" |    |    |  |  |     /     \ |    | |/  \|
"=============================================

scriptencoding utf8


" Pseudo `source .venv/bin/activate` automatically {{{

let s:venv_dir = v:null

function s:cleanup()
  if s:venv_dir == v:null
    return
  endif

  let l:entries = split($PATH, ':')
  let l:entries = filter(l:entries, 'v:val !=# s:venv_dir')
  let $PATH = join(l:entries, ':')
  let s:venv_dir = v:null
endfunction

function s:init()
  let l:dir = v:event.cwd

  for l:dot in ['.venv', '.env']
    let l:venv = l:dir . '/' . l:dot . '/bin'
    if isdirectory(l:venv)
      let $PATH = l:venv . $PATH
      let s:venv_dir = l:venv
      echomsg 'Add ' . l:venv . ' to . $PATH'
      return
    endif
  endfor
endfunction

autocmd Meowrc DirChangedPre * call s:cleanup()
autocmd Meowrc DirChanged * call s:init()

" }}}
