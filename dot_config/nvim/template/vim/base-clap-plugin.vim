if exists('g:loaded_clap_{{_input_:name}}')
  finish
endif
let g:loaded_clap_{{_input_:name}} = 1
let s:save_cpo = &cpo
set cpo&vim

command! Clap{{_input_:name}}  call clap#init(clap#{{_input_:name}}#id())
" command! Clap{{_input_:name}}  call clap#{{_input_:name}}#prompt()

let &cpo = s:save_cpo
unlet s:save_cpo

