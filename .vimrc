"----------------------------------------------------------
" 文字コードの指定
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,utf-8,euc-jp,cp932

"----------------------------------------------------------
" タブの画面上での幅
set tabstop=2
" タブをスペースに展開(expandtab:展開する) 
set expandtab
" 行数表示
set nu
" ルーラーを表示 (noruler:非表示) 
set ruler
" タブや改行を表示 (list:表示) 
set nolist

"---------------------------------------------------------
" 自動的にインデントする (noautoindent:インデントしない) 
" set autoindent
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
"---------------------------------------------------------
" プラグインファイルの置き場所を追加する
" http://nanasi.jp/articles/howto/config/runtimepath.html
"set runtimepath+=$HOME/.vim/runtime,$HOME/.vim/,$HOME/.vim,$HOME/.vim/runtime/syntax,$HOME/.vim/ftpplugin
" syntaxを追加する
augroup filetypedetect
au BufNewFile,BufRead *.as  setf actionscript
augroup END 

if has('gui_macvim')
  set showtabline=2  // タブを常に表示
  set imdisable      // IMを無効化
  set transparency=0 // 透明度を指定
  set guifont=Monaco:h14
  map <silent> gw :macaction selectNextWindow:
  map <silent> gW :macaction selectPreviousWindow:
  defaults write org.vim.MacVim MMTerminateAfterLastWindowClosed yes //最後のウィンドウを閉じたときに自動的にMacVimを終了
  defaults write org.vim.MacVim MMOpenFilesInTabs yes //ファイルをドロップしたときにタブで開く
endif