"========================
" |_/ |\  |\__    \    /
" |_  | \ |   \     \/
" | \ |   |    |   /  \
"     |   |    | /     \
"========================

scriptencoding utf-8

let g:vim_plug_cache_dir = '~/.vim-temp/plug'

call plug#begin(g:vim_plug_cache_dir)

Plug 'kien/ctrlp.vim'

Plug 'aiya000/aho-bakaup.vim'
Plug 'ainnhe/everforest'
Plug 'tyru/caw.vim'

" Operator
Plug 'emonkak/vim-operator-sort'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'osyo-manga/vim-operator-stay-cursor'
Plug 'rhysd/vim-operator-surround'
Plug 'tommcdo/vim-exchange'
Plug 'wellle/targets.vim'

" Text Object
"     b   = Any brackets
"     fX  = beetween X - http://d.hatena.ne.jp/thinca/20100614/1276448745
"     i   = Indent Level
"     u   = URL
"     y   = Syntax
"     z   = Fold
"     ae  = Entire
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-entire'
Plug 'mattn/vim-textobj-url'
Plug 'osyo-manga/vim-textobj-multiblock'

call plug#end()
