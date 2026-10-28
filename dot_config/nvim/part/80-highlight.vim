augroup Meowrc
  " Pakuri from https://github.com/kawarimidoll/dotfiles/blob/69b6d0f9f7fb09829da5d0287581e4a02d340794/.vim/vimrc#L1106-L1119

  " Highlight extra whitespaces
  " https://zenn.dev/kawarimidoll/articles/450a1c7754bde6
  " u00A0 ' ' no-break space
  " u2000 ' ' en quad
  " u2001 ' ' em quad
  " u2002 ' ' en space
  " u2003 ' ' em space
  " u2004 ' ' three-per em space
  " u2005 ' ' four-per em space
  " u2006 ' ' six-per em space
  " u2007 ' ' figure space
  " u2008 ' ' punctuation space
  " u2009 ' ' thin space
  " u200A ' ' hair space
  " u200B '​' zero-width space
  " u3000 '　' ideographic (zenkaku) space
  highlight ExtraWhitespace ctermbg=magenta guibg=magenta
  autocmd VimEnter,WinEnter * if !exists('w:anekos_highlight_extra_whitespace')
        \ | let w:anekos_highlight_extra_whitespace = matchadd('ExtraWhitespace', "[\u00A0\u2000-\u200B\u3000]")
        \ | endif
augroup END
