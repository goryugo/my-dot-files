"----------------------------------------------------------
" 文字コードの指定
"----------------------------------------------------------
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,utf-8,euc-jp,cp932

"----------------------------------------------------------
"基本設定
"----------------------------------------------------------
set autoread                   " 他で書き換えられたら自動で読み直す
set backup
set backupdir=~/Dropbox/bak    " バックアップの場所
set hidden                     " 編集中でも他のファイルを開けるようにする
set noswapfile
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set vb t_vb=                   " ビープをならさない
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set showcmd                    " コマンドをステータス行に表示
:set clipboard+=unnamed        " 無名レジスタに入るデータを、*レジスタにも入れる。
:set clipboard+=autoselect     " ビジュアルモードの選択テキストをクリップボードに

"----------------------------------------------------------
"ステータスライン
"----------------------------------------------------------
set laststatus=2 "常にステータスラインを表示
set statusline=%<%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %F%=%v\ %l/%L(%P)%m

"----------------------------------------------------------
"表示
"----------------------------------------------------------
"タブの画面上での幅
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab " タブをスペースに展開(expandtab:展開する)
set nu        " 行数表示
set nolist    " タブや改行を表示(list:表示)
set showmatch " 括弧の対応をハイライト
set showcmd   " 入力中のコマンドを表示

"---------------------------------------------------------
" 補完・履歴
"---------------------------------------------------------
set wildmenu           " コマンド補完を強化
set wildchar=<tab>     " コマンド補完を開始するキー
set wildmode=list:full " リスト表示，最長マッチ
set history=1000       " コマンド・検索パターンの履歴数
set complete+=k        " 補完に辞書ファイル追加

"---------------------------------------------------------
" 検索設定
"---------------------------------------------------------
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
"その他
"---------------------------------------------------------
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
"esc連打で検索ハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"-------------------------------------------------------------------------------
" キーバインド関係
"-------------------------------------------------------------------------------
 
" 行単位で移動(1行が長い場合に便利)
nnoremap j gj
nnoremap k gk
 
" バッファ周り
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprev<CR>
nmap <silent> ,l    :BufExplorer<CR>"動かず
 
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

" コマンドラインでのキーバインドを Emacs スタイルにする
" Ctrl+Aで行頭へ移動
:cnoremap <C-A>		<Home>
" Ctrl+Bで一文字戻る
:cnoremap <C-B>		<Left>
" Ctrl+Dでカーソルの下の文字を削除
:cnoremap <C-D>		<Del>
" Ctrl+Eで行末へ移動
:cnoremap <C-E>		<End>
" Ctrl+Fで一文字進む
:cnoremap <C-F>		<Right>
" Ctrl+Nでコマンドライン履歴を一つ進む
:cnoremap <C-N>		<Down>
" Ctrl+Pでコマンドライン履歴を一つ戻る
:cnoremap <C-P>		<Up>
" Alt+Ctrl+Bで前の単語へ移動
:cnoremap <Esc><C-B>	<S-Left>
" Alt+Ctrl+Fで次の単語へ移動
:cnoremap <Esc><C-F>	<S-Right> 

"------------------------------------------------------------
"テンプレートファイル
"------------------------------------------------------------
augroup SkeletonAu
    autocmd!
    autocmd BufNewFile *.html 0r $HOME/Dropbox/templates/skelton.html
    autocmd BufNewFile *.cgi 0r $HOME/Dropbox/templates/skelton.cgi
    autocmd BufNewFile *.pl 0r $HOME/Dropbox/templates/skelton.cgi
augroup END

"------------------------------------------------------------
"ファイルタイプ関連付け
"------------------------------------------------------------
augroup filetypedetect
  autocmd!
  autocmd BufNewFile,BufRead clmemo.txt set filetype=changelog
augroup END

"------------------------------------------------------------
"ChangeLog
"------------------------------------------------------------
let g:changelog_username="Ryusuke Goto  <goryugo33@gmail.com>"
let g:changelog_timeformat="%Y-%m-%d"

"------------------------------------------------------------
"コンパイラ
"------------------------------------------------------------
autocmd FileType perl,cgi :compiler perl  

"-------------------------------------------------------------------------------
"プラグイン
"-------------------------------------------------------------------------------
"YankRing動かない?


