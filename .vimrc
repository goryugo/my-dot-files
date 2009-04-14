"----------------------------------------------------------
" 文字コードの指定
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,utf-8,euc-jp,cp932

"----------------------------------------------------------
"ステータスライン
set laststatus=2 " 常にステータスラインを表示
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L(%P)%m

"----------------------------------------------------------
"基本設定
set autoread                   " 他で書き換えられたら自動で読み直す
set noswapfile                 " スワップファイル作らない
set hidden                     " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set vb t_vb=                   " ビープをならさない
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set showcmd					" コマンドをステータス行に表示

"----------------------------------------------------------
"表示

"タブの画面上での幅
set tabstop=2
" タブをスペースに展開(expandtab:展開する) 
set expandtab
" 行数表示
set nu
" タブや改行を表示 (list:表示) 
set nolist

set showmatch		 " 括弧の対応をハイライト
set showcmd		   " 入力中のコマンドを表示
set number			" 行番号表示

"---------------------------------------------------------
" 補完・履歴
set wildmenu		   " コマンド補完を強化
set wildchar=<tab>	 " コマンド補完を開始するキー
set wildmode=list:full " リスト表示，最長マッチ
set history=1000	   " コマンド・検索パターンの履歴数
set complete+=k		" 補完に辞書ファイル追加
"-------------------------------------------------------------------------------
" 検索設定
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

"---------------------------------------------------------
" 自動的にインデントする (noautoindent:インデントしない) 
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない) 
set wrapscan
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1    " ぶら下り可能幅
" コマンドをステータス行に表示
set showcmd
"-------------------------------------------------------------------------------
" キーバインド関係
 
" 行単位で移動(1行が長い場合に便利)
nnoremap j gj
nnoremap k gk
 
" バッファ周り
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>
nmap <silent> ,l    :BufExplorer<CR>
 
" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap G Gzz
 
"usキーボードで使いやすく
nmap ; :

