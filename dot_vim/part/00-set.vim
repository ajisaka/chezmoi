"=================
" |    |\  /| /|\
" | /| | \/ |  |
" |/ | |    |  |
"    | |    |  |
"=================

scriptencoding utf8

" メニューの日本語化を抑止
set langmenu=none

" 改行コード
set fileformats=unix,mac,dos
set fileformat=unix

" 行数表示
set nonumber
set norelativenumber

" 検索結果をハイライト
set hlsearch

" 括弧の対応表示
set showmatch

" 括弧入力時の対応括弧ジャンプ時間
set matchtime=1

" バックスペース設定 (インデントやeolを消せるようにする)
set backspace=indent,eol,start

" set list 時の表示
set listchars=tab:>-,extends:ᛖ,precedes:ᛈ,nbsp:ᛋ,trail:ᛋ

" IMをデフォでは働かせないように
set iminsert=0
set imsearch=0

" 常にステータスライン表示
if has('nvim')
  set laststatus=3
else
  set laststatus=2
endif

" cygwin などのパーミッションを上書きするのを帽子
" http://d.hatena.ne.jp/msakamoto-sf/20071125/1195979751
set backupcopy=yes

" 選択モード
set selectmode=

" 保存していないバッファを隠せるようにする
set hidden

" バックアップしない (念の為ディレクトリ設定しておく)
set nobackup
set backupdir=~/.vim-temp/backup//

" スワップディレクトリ
set directory=~/.vim-temp/swap//

" undo を復元してくれるよ!
set undofile
if has('nvim')
  set undodir=~/.vim-temp/neovim/undo//
else
  set undodir=~/.vim-temp/undo//
endif

" View ディレクトリ
set viewdir=~/.vim-temp/view//

" 補完設定
set complete=.,b,w,u,k
set completeopt=menuone,noinsert,noselect,preview

" 入力中のコマンドをステータスに表示する
set showcmd

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
set smartcase

" インクリメンタルサーチ
set incsearch

" コマンドラインの行数
set cmdheight=2

" <C-x> <C-a> で使う基数
set nrformats=unsigned

" スクロール余白
set scrolljump=-50
set scrolloff=5

" 貼り付け時の挙動
set nopaste

" ファイルが外部から変更されたときに自動でロードしない
set autoread

" カレント .vimrc, .exrc などを読まない
set noexrc

" 復元機能
set viewoptions=cursor,slash

" タブなどを表示する
set list

" マーカーで折りたたむ
set foldmethod=marker

" デフォルトでは開いておく
set foldlevel=666

" タブ＆インデント
set tabstop=2 shiftwidth=2 autoindent expandtab smarttab copyindent preserveindent

" 補完メニュー強化
set wildmenu
set wildchar=<Tab>
set wildignore=*.o,*.obj,*.la,*.a,*.exe,*.com,*.so,*.beam,*.hi,*.~*

" 折り返し検索
set wrapscan

" 一行を全部表示
set display=lastline

" う゛ぃみんふぉ
set viminfo=
set viminfo+='1000                     " マークが復元される履歴の最大
set viminfo+=<50                       " 各レジスタで保存される行数の最大値
set viminfo+=s50                       " Kbyte単位でのフラグの最大値
set viminfo+=h                         " viminfo ファイルの読み込み時に、'hlsearch' を無効にする。
set viminfo+=!                         " 大文字のみで構成されるグローバル変数を保存する
if has('nvim')
  set viminfo+=n~/.vim-temp/neovim/info/viminfo " viminfo の保存場所
else
  set viminfo+=n~/.vim-temp/info/viminfo " viminfo の保存場所
endif

" ウィンドウサイズの自動調整
set noequalalways

" ヘルプの検索順
set helplang=ja

" セッションで保存する要素
set sessionoptions=blank,buffers,curdir,folds,resize,tabpages

" カカッ!
set secure

" Don't save options.
set viewoptions-=options

" K
set keywordprg=

" ++
set history=10000

" clipboard
set clipboard=

" iskeyword ← 説明になってない!
set iskeyword=@,48-57,-,_,192-255

" こいつらをファイル・メイとして認めてやらんこともない
set isfname=@,48-57,/,.,-,_,~

" キー入力のタイムアウト
set timeoutlen=750
set ttimeoutlen=250

" 右クリックめぬーでぽっぽあっぽ
set mousemodel=popup

" 矩形ビジュアルモードでカーソルを範囲外まで移動できるようにする
set virtualedit=block

" 選択時の行末関係の挙動 (exclusive にすると vim-sexp の挙動がおかしくなる)
set selection=inclusive

" for :grep
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude='*.json'\ --exclude='*.log'\ --exclude='*min.js'\ --exclude='*min.css'

" メッセージの省略
set shortmess=tToOlmnrwxfF

" CursorHold とかに使われるね
set updatetime=300

" 長すぎる行で重くなると嫌ですね
" set synmaxcol=666

" タイトルの文字 ↓ わかりづらいね!
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Oppiroge
set conceallevel=0

" ウィンドウサイズを自動で同じにする
set equalalways
set eadirection=both

" 正規表現エンジン
if v:version >= 800
  set regexpengine=0 " 0=自動選択, 1=old, 2=Neko Felis Association
endif

" 絵文字全角
if has('multi_byte')
  set emoji
endif

" 破壊いぬでんと
    " 🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕
if has('linebreak')
  set breakindent
endif

" カラフフ
if has('termguicolors')
  set termguicolors
endif

" 暗い
set background=dark

" 折り返し時に表示するやつ
set showbreak=›››\ 

" on screen (tmux)
if &term == 'screen'
  set t_kb=
endif

" うっさいぼけ
set belloff=all

if has('nvim')
  set mouse=
  set pumborder=rounded
  set completeopt+=popup
endif

if executable(expand('~/script/vim/make'))
  set makeprg=~/script/vim/make
endif

if executable('/bin/bash')
  set shell=/bin/bash
endif
