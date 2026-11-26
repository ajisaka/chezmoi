"======================================================================================
"
"       ___           ___           ___           ___           ___           ___
"      /\  \         /\  \         /\__\         /|  |         /\  \         /\__\
"     /::\  \        \:\  \       /:/ _/_       |:|  |        /::\  \       /:/ _/_
"    /:/\:\  \        \:\  \     /:/ /\__\      |:|  |       /:/\:\  \     /:/ /\  \
"   /:/ /::\  \   _____\:\  \   /:/ /:/ _/_   __|:|  |      /:/  \:\  \   /:/ /::\  \
"  /:/_/:/\:\__\ /::::::::\__\ /:/_/:/ /\__\ /\ |:|__|____ /:/__/ \:\__\ /:/_/:/\:\__\
"  \:\/:/  \/__/ \:\~~\~~\/__/ \:\/:/ /:/  / \:\/:::::/__/ \:\  \ /:/  / \:\/:/ /:/  /
"   \::/__/       \:\  \        \::/_/:/  /   \::/~~/~      \:\  /:/  /   \::/ /:/  /
"    \:\  \        \:\  \        \:\/:/  /     \:\~~\        \:\/:/  /     \/_/:/  /
"     \:\__\        \:\__\        \::/  /       \:\__\        \::/  /        /:/  /
"      \/__/         \/__/         \/__/         \/__/         \/__/         \/__/
"
"                                                               vim: set ts=2 sw=2 et :
"======================================================================================


" Safety {{{

if !has('unix') && has('macunix')
  echo 'huh?'
  silent! quitall!
endif

" }}}

" Reloadablerrr {{{

augroup Meowrc
  autocmd!
augroup END
command! -bang -nargs=* MeowtoCmd autocmd<bang> Meowrc <args>

" }}}

" Detect env {{{

if $HOSTNAME =~ '\.compute\.internal$'
  let g:anekos_env_name = 'EC2'
else
  let g:anekos_env_name = 'unknown'
endif

" }}}

" Encoding {{{

set encoding=utf8
let &termencoding = &encoding
scriptencoding utf8
set fileencodings=utf8,ms932

" }}}

" " 起動時間を計測 (from .thincarc) {{{
"
" if has('vim_starting') && has('reltime')
"   let g:startuptime = reltime()
"   MeowtoCmd VimEnter * let g:startuptime = reltime(g:startuptime)
" \                  | redraw
" \                  | echomsg 'startuptime: ' . reltimestr(g:startuptime)
" endif
"
" " }}}

" ショッキカ {{{

if !isdirectory(expand('~/.vim-temp'))
  function s:initialize()
    let l:dirs = split('backup bakaup swap undo view info')
    for l:dir in l:dirs
      call mkdir(expand('~/.vim-temp/') . l:dir, 'p')
    endfor

    source ~/.vim/part/10-plug.vim
    PlugInstall
    quitall!
  endfunction

  call s:initialize()
endif

" }}}

" ショッキチ {{{

let g:hi_dpi = 0

" }}}

" 分割 rc {{{

let s:plug_rc_names = []

function! s:source_file(file)
  let l:file = expand(a:file)
  if !filereadable(l:file) | return | endif

  let l:file_ext = fnamemodify(a:file, ':e')
  let l:rc_name = fnamemodify(a:file, ':t:r:s?\d\d-??')

  if !has('nvim') && l:file_ext == 'lua'
    return
  endif

  " `50-plugin/foo` みたいなのはプラグイン用
  let l:on_plugin_dir = fnamemodify(a:file, ':h:t:s?\d\d-??') == 'plugin'

  " プラグイン用なら Plug でロードされているかを調べて、ロードするか決める
  if l:on_plugin_dir && has_key(g:, 'plugs')
    " `ctrlp-plugin_rc` でプラグイン名を変形しているので、それに対応する
    if s:plug_rc_names == []
      let s:plug_rc_names = map(keys(g:plugs), "substitute(v:val, '\\v^n?vim[-._]|[-._]n?vim$', '', 'g')")
    endif
    " ロードされていない場合は、設定用のファイルも読まない
    if count(s:plug_rc_names, l:rc_name) == 0
      " XXX コメントアウトを外すと、設定ファイルがあるのみロードされてないプラグインがわかるぞ
      " echo l:rc_name
      return
    endif
  endif

  " 満を持してロードする
  execute 'source' l:file
endfunction

function! s:compare_filename(x, y)
  let l:x = fnamemodify(a:x, ':t')
  let l:y = fnamemodify(a:y, ':t')
  if l:x == l:y
    return 0
  elseif l:x < l:y
    return -1
  else
    return 1
  endif
  return
endfunction

function! s:source_dir(dirs)
  let l:entries = globpath(a:dirs, '*', v:true, v:true)
  call sort(l:entries, funcref('s:compare_filename'))

  for l:filepath in l:entries
    let l:filename = fnamemodify(l:filepath, ':t')
    if l:filename !~ '\v^[0-9]{2}[-_].+' | continue | endif
    if isdirectory(l:filepath)
      call s:source_dir(l:filepath)
    else
      call s:source_file(l:filepath)
    endif
  endfor
endfunction

function! s:source_parted()
  call s:source_file('~/local/.vimrc.before')
  call s:source_dir('~/.vim/part,~/local/.vim/part')
  call s:source_file('~/.vimrc.local')
  call s:source_file('~/local/.vimrc.after')
endfunction

call s:source_parted()

" }}}
