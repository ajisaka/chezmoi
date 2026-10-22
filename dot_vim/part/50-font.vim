scriptencoding utf8

" Nerd Fonts - https://github.com/ryanoasis/nerd-fonts
"   /usr/share/fonts/nerd-fonts-complete/TTF/

if !has('gui_running') && !(has('nvim'))
  finish
endif

let s:default_font_size = 10
if exists('g:neovide')
  let s:default_font_size = 12
endif

let s:font_size = s:default_font_size
let s:font_name = v:null

" Font Settings {{{

let s:fonts = {
\   'nerd': {
\     'font': 'DroidSansMono Nerd Font Mono',
\     'wide': 'Ricty'
\   },
\   'rune': {
\     'font': 'New Britannia Runic Stroke',
\     'wide': 'Ricty'
\   }
\ }

" }}}

" Font Command {{{

function! s:set_font (name, size)
  if a:name == ''
    echoerr 'Font name is empty'
    return
  endif

  if has_key(s:fonts, a:name)
    let l:setting = s:fonts[a:name]
    let s:font_name = a:name
  else
    let l:name = a:name
    let l:name = fnamemodify(l:name, ':t:r')
    let l:setting = {'font': l:name, 'wide': l:name}
    let s:font_name = l:name
  endif

  if a:size == 0
    let l:font_size = s:font_size
  else
    let l:font_size = a:size
  endif

  " See ~/local/.vimrc.before for `g:hi_dpi`
  if g:hi_dpi && $DESKTOP_SESSION !=# 'gnome' && $GDK_SCALE !=# 2
    let l:font_size *= 2
  endif

  if has('nvim')
    let &guifont = l:setting.font . ':h' . l:font_size
    let &guifontwide = l:setting.wide . ':h' . l:font_size
    return
  endif

  let &guifont = l:setting.font . ' ' . l:font_size
  if has('gui_gtk')
    let &guifontwide = get(l:setting, 'wide', l:setting.font) . ' ' . l:font_size
  endif
endfunction

function! s:font_list ()
  return map(systemlist('fc-list : family'), 'split(v:val, ",")[0]')
endfunction

function! s:complete_font (...)
  let l:fonts = keys(s:fonts) + s:font_list()
  let l:fonts = uniq(sort(l:fonts))
  return join(l:fonts, "\n")
endfunction

command! -nargs=* -complete=custom,s:complete_font Font call s:set_font(<q-args>, 0)

" }}}

" Font Size {{{
"
function! s:set_font_size (size)
  if a:size[0] == '+'
    let s:font_size += str2nr(a:size[1:])
  elseif a:size[0] == '-'
    let s:font_size -= str2nr(a:size[1:])
  elseif a:size == ''
    let s:font_size = s:default_font_size
  else
    let s:font_size = str2nr(a:size)
  endif
  call s:set_font(s:font_name, 0)
endfunction

command! -nargs=* -complete=custom,s:complete_font FontSize call s:set_font_size(<q-args>)

" }}}

" Mappings {{{
nnoremap <silent> <Plug>(fontzoom-larger)
\                 :<C-u>FontSize +<C-r>=v:count1<CR><CR>
nnoremap <silent> <Plug>(fontzoom-smaller)
\                 :<C-u>FontSize -<C-r>=v:count1<CR><CR>

silent! nmap <silent> <C-ScrollWheelUp> <Plug>(fontzoom-larger)
silent! nmap <silent> <C-ScrollWheelDown> <Plug>(fontzoom-smaller)

" }}}

Font FiraCode Nerd Font Mono
" Font nerd
