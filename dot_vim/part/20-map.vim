"=================
" |\  /| |\   |_/
" | /\ | |\ \ |_
" |/  \| |  \ | \
" |    | |
"=================

scriptencoding utf8

let g:mapleader = ','
nmap s <Leader>
xmap s <Leader>

" 小指を鍛えるエディタ風
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

" コマンドモードの移動
cnoremap <C-a> <Home>
cnoremap <C-d> <Del>

" 検索時に結果が中央に来るようにする
noremap n nzzzv
noremap N Nzzzv

" incsearch.vim
" nnoremap /  /\v
" nnoremap ?  /\v

" for US KBD
nnoremap : ;
nnoremap ; :

if v:false
  " Use command-line window
  nnoremap <expr> ; quickrun#hook#lightline_quickrun_status#current() ==# '' ? 'q:' : ':'
  xnoremap <expr> ; quickrun#hook#lightline_quickrun_status#current() ==# '' ? 'q:' : ':'
  nnoremap <Leader>: :
  xnoremap <Leader>: :
  nnoremap q: :
  xnoremap q: :
else
  xnoremap : ;
  xnoremap ; :
endif

" JK ワイパー
inoremap jk <Esc>
inoremap kj <Esc>

" Don't move on *
nnoremap * *<C-o>
nnoremap # #<C-o>

" 自然派
nnoremap Y y$

" タブ
nnoremap gh 1gt

" quickfix
nnoremap <Leader>cp <Cmd>cprevious<CR>
nnoremap <Leader>cn <Cmd>cnext<CR>
nnoremap <Leader>cf <Cmd>cfirst<CR>
nnoremap <Leader>cl <Cmd>clast<CR>

" 小窓を大きくする風
nnoremap <C-w>o <Cmd>MaximizeModoki<CR>

" 誤爆抑止
nnoremap S <nop>

" https://github.com/aramisgithub/dotfiles/blob/a6e7cab09cf414add888fa147a2849544cb67f09/files/vim/vimrc
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" 挿入モードでの移動
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" Omni Completion
inoremap <C-Space> <C-x><C-o>

" コマンドラインで履歴たぐり
cnoremap <C-k> <Up>
cnoremap <C-l> <Down>

" Ignore ex mode
nnoremap Q <Nop>

" Tab
nnoremap <C-n> <Cmd>tabnext<CR>
nnoremap <C-p> <Cmd>tabprev<CR>

" Emacs ライクなキャンセル
cnoremap <C-g> <C-c>

" like ranger
nnoremap <expr> cd ":\<C-u>cd\<Space>" . fnamemodify(get(t:, 'cwd', '~/'), ':~:.') . "\<C-f>"

" 改行
nnoremap <CR> A<CR><Esc>

" for vimeight
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" Repeat on visual mode
vnoremap <silent> . <Cmd>normal .<CR>

" buffer
nnoremap <Leader>x <Cmd>wincmd c<CR>

" tab
nnoremap <Leader>tn <Cmd>tabnew<CR>
nnoremap <Leader>te :<C-u>tabedit<Space><C-f>
nnoremap <Leader>tx <Cmd>tabclose<CR>

" 保存 ﾎﾟﾗﾎﾟﾗﾎﾟﾗ
nnoremap <Leader>w <Cmd>update<CR>
nnoremap <Leader>W <Cmd>wall<CR>
nnoremap <Leader>z ZZ

" Show something
if !has('nvim')
  nnoremap <C-g> <Cmd>ShowSomething<CR>
endif

" jumplist
nnoremap <C-k> <Cmd>cprev<CR>
nnoremap <C-l> <Cmd>cnext<CR>
nnoremap <C-b> <Cmd>lprev<CR>
nnoremap <C-f> <Cmd>lnext<CR>

" Checktime
nnoremap <Leader><Leader>c <Cmd>checktime<CR>

" Remove search highlgiht
nnoremap <Leader>! <Cmd>nohlsearch<CR>

" 全角でかかないようにする
scriptencoding utf8
inoremap 　 <Space>
inoremap （ (
inoremap ） )
inoremap ｛ {
inoremap ｝ }
inoremap ； ;
inoremap ： :
inoremap ｜ <Bar>
inoremap ＜ <
inoremap ＞ >
inoremap ＊ *
inoremap ＠ @
inoremap － -
inoremap ％ %
inoremap ＃ #
inoremap ” "
inoremap ’ '
inoremap ＋ +
inoremap ０ 0
inoremap １ 1
inoremap ２ 2
inoremap ３ 3
inoremap ４ 4
inoremap ５ 5
inoremap ６ 6
inoremap ７ 7
inoremap ８ 8
inoremap ９ 9
inoremap ～ ~
inoremap ？ ?
