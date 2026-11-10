
setlocal nocindent
setlocal expandtab

" imap <buffer> [ (
" imap <buffer> ] )

setlocal omnifunc=lispcomplete#Complete

nnoremap <buffer> <Leader><Leader>r :<C-u>Unite hyperspec<CR>
