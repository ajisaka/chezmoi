map <silent>Sa <Plug>(operator-surround-append)
map <silent>Sd <Plug>(operator-surround-delete)
map <silent>Sr <Plug>(operator-surround-replace)
nmap <silent>Sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
nmap <silent>Srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

" {} b = Block
" [] s = Square bracket
" () p = Parentheses
" <> t = hoge Than moge

let g:operator#surround#blocks = {
\   '-' : [
\       {'block': ['{', '}'], 'motionwise': ['char', 'line', 'block'], 'keys': ['b', '7', '8'] },
\       {'block': ['[', ']'], 'motionwise': ['char', 'line', 'block'], 'keys': ['s', 'u', 'i'] },
\       {'block': ['(', ')'], 'motionwise': ['char', 'line', 'block'], 'keys': ['p', 'j', 'k'] },
\       {'block': ['<', '>'], 'motionwise': ['char', 'line', 'block'], 'keys': ['t', 'm', 'l'] },
\   ]
\ }
