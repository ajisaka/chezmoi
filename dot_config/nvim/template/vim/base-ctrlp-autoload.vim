" Init {{{
if exists('g:loaded_clap_{{_input_:name}}_autoload') && g:loaded_clap_{{_input_:name}}_autoload
  finish
endif

let g:loaded_clap_{{_input_:name}}_autoload = 1
let s:save_cpo = &cpo
set cpo&vim
" }}}

" Main {{{
function s:{{_input_:name}}_source()
  return ['a', 'b', '{{_input_:name}}']
endfunction

function s:{{_input_:name}}_sink(selected)
  execute 'QuickRun' a:selected
endfunction

let s:{{_input_:name}} = {}
let s:{{_input_:name}}.sink = function('s:{{_input_:name}}_sink')
let s:{{_input_:name}}.source = function('s:{{_input_:name}}_source')
let s:{{_input_:name}}.on_enter = { -> g:clap.display.setbufvar('&ft', 'clap_{{_input_:name}}') }

let g:clap#provider#{{_input_:name}}# = s:{{_input_:name}}

" }}}

" Finalize {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}

