if exists('g:loaded_XXX')
  finish
endif
let g:loaded_XXX = 1
let s:save_cpo = &cpo
set cpo&vim

command! CtrlPGrep  call ctrlp#grep#prompt()

let &cpo = s:save_cpo
unlet s:save_cpo

