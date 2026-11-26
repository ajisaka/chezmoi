"===============================================
"   /
"   |     |\    |\  /| |\  /| |\     |   |\  /|
"  /\     |\ \/ | /\ | | /\ | |\ \  _|_| | \/ |
" |   \   | \/  |/  \| |/  \| |  \ | |   | /\ |
" /     \ |     |    | |    | |      |   |/  \|
"===============================================

scriptencoding utf8

" カレントファイルのパスをクリプボぅ! {{{

command! -nargs=* -bang -bar CopyCurrentFilepath :call s:copy_current_filepath('<bang>', <q-args>)

function! s:copy_current_filepath(bang, modifier)
  let l:path = expand('%' . a:modifier)
  if a:bang ==# '!'
    let l:path = printf('L%d@%s', line('.'), l:path)
  endif
  let @* = l:path
  let @+ = l:path
  echo printf('>> %s', l:path)
endfunction

" }}}

" 選択した行番号をコピペ {{{

function! s:ln(start, end, filename_modifier)
  if a:start == a:end
    let l:ln = printf('L%d', a:start)
  else
    let l:ln = printf('L%d-%d', a:start, a:end)
  endif

  if len(a:filename_modifier) > 0
    let l:ln =  expand('%' . a:filename_modifier) . '#' . l:ln
  endif

  let @+ = l:ln
  let @* = l:ln
  echo l:ln
endfunction

" e.g)
"   :'<,'>Ln
"   :Ln
"   :Ln :t
command! -bar -range -nargs=? Ln call s:ln(<line1>, <Line2>, <q-args>)

" }}}

" ファイル名っぽいのをカーソル周辺から探してジャンプするんだね {{{

let s:jump_code_range = 10

function! s:remove_esc_seq (line)
  return substitute(a:line, '\e\[[^m]*m', '', 'g')
endfunction

function! s:extract_code_path (line)
  let l:line = s:remove_esc_seq(a:line)
  let l:match = matchlist(l:line, '\v(%([-_.a-z0-9]*/)*%([-_.a-z0-9]+))%(:(\d+))%(:(\d+))?')
  if len(l:match) > 0
    let l:filepath = l:match[1]
    let l:line = str2nr(l:match[2])
    let l:col = str2nr(l:match[3])

    if filereadable(l:filepath)
      return [1, l:filepath, l:line, l:col]
    endif
  endif

  return [0, 0, 0, 1]
endfunction

function! s:jump_to_file (filepath, ln, col)
  1wincmd w

  if fnamemodify(bufname(winbufnr(1)), ':p') !=# fnamemodify(a:filepath, ':p')
    execute 'edit' a:filepath
  endif

  if a:ln
    execute a:ln
  endif

  if a:col
    if a:col == 1
      normal! 0
    else
      execute 'normal!' printf('0%dl', a:col - 1)
    endif
  endif

  normal! zz
endfunction

function! s:jump_code ()
  let l:line = line('.')

  for l:i in range(0, s:jump_code_range)

    let l:target_ln = l:line - l:i
    let [l:found, l:filepath, l:ln, l:col] = s:extract_code_path(getline(l:target_ln))

    if !l:found
      let l:target_ln = l:line + l:i
      let [l:found, l:filepath, l:ln, l:col] = s:extract_code_path(getline(l:target_ln))
    endif

    if l:found
      if l:ln == 0
        let l:matched = matchlist(getline(l:target_ln + 1), '\(\d\+\)\(:\(\d\+\)\)\=')
        if len(l:matched) > 0
          let l:ln = str2nr(l:matched[1])
          let l:col = str2nr(l:matched[3])
        endif
      endif

      call s:jump_to_file(l:filepath, l:ln, l:col)
      return
    end
  endfor
endfunction

command! -bar JumpCode call s:jump_code()

" }}}

" ヘルプ以外の空バッファウィンドウを閉じる {{{

function! s:kill_me_baby ()
  let l:blanks = 0
  let l:helps = 0
  for l:n in tabpagebuflist()
    if getbufvar(l:n, '&filetype') ==# 'help'
      let l:helps += 1
    elseif bufname(l:n) ==# ''
      let l:blanks += 1
    endif
  endfor

  if l:blanks > 0 && l:helps > 0
    silent! only
  endif
endfunction

command! -bar KillMeBaby call s:kill_me_baby()

" }}}

" cpo の設定を後付け {{{

function! s:insert_cpo()
  call append(0, ['let s:save_cpo = &cpo', 'set cpo&vim', '', ''])
  call append(line('$'), ['', '', 'let &cpo = s:save_cpo', 'unlet s:save_cpo'])
  normal! gg
  redraw
  sleep 1
  normal! G
endfunction

command! -bar InsertCpo call s:insert_cpo()

" }}}

" バッファを grep {{{

function! s:buffer_grep(query)
  execute 'silent!' 'bufdo' 'vimgrepadd' printf('/%s/', escape(a:query, '/\')) '%'
endfunction

command! -bar -nargs=* BGrep call s:buffer_grep(<q-args>)

" }}}

" figlet {{{

" rc ファイルヘッダ用
" http://ultimacodex.com/archive/runic/ 内の http://ultimacodex.com/archive/ftp/misc/fonts/runeflf.zip
command! -nargs=* Figlet .! figlet -d ~/.figlet -f rune -w 1000 <q-args>

" }}}

" 文字ケース変換 {{{

function! s:to_underscore_case ()
  let l:words = substitute(substitute(expand('<cword>'), '^.', '\l\0', ''), '\C\([A-Z]\+\)', '_\l\1', 'g')
  execute 'normal!' 'ciw' . l:words
endfunction

command! -bar CaseUnderScore call s:to_underscore_case()

" }}}

" chezmoi 管理下のファイルとして開きなおす {{{

function! s:AsChezmoi()
  let l:current_path = expand('%:p')
  let l:source_path = system('chezmoi source-path ' . shellescape(l:current_path))
  execute 'edit' l:source_path
  echomsg printf('>> %s', l:source_path)
endfunction

command! AsChezmoi call s:AsChezmoi()

" }}}
