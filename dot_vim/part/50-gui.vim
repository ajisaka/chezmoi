"==================
"  \    / |\__   |
"    \/   |   \  |
"   /  \  |    | |
" /     \ |    | |
"==================

scriptencoding utf8

if !has('gui_running') && !(has('nvim'))
  finish
endif

nnoremap <C-z> <Nop>

set guioptions=gitc
"  1 hoge.vim
set guitablabel=%N:\ %f
