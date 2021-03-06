"-------------------------------------------------------------------------------
" デザイン
colorscheme desert		 " カラースキーム
set guifont=Monaco:h14		 "font
set antialias			  " アンチエイリアシング
if has('gui_macvim')
  nnoremap / g/ " デフォルトでmigemo検索
  set transparency=5	   " 半透明
endif
set guioptions-=T		  " ツールバー削除
highlight CursorLine ctermbg=black guibg=gray10  " カーソル行の色

" 挿入モード・検索モードでのデフォルトのIME状態設定
set iminsert=0 imsearch=0

"日本語入力中のカーソルの色
"highlight Cursor guifg=NONE guibg=Green
highlight CursorIM guifg=NONE guibg=Red

filetype indent on " ファイルタイプによるインデント
filetype plugin on " ファイルタイプごとのプラグイン


"----------------------------------------------------------
" ウィンドウ
set sessionoptions+=resize " 行・列を設定する
set lines=1000                      " 行数
set columns=1000                        " 横幅
set cmdheight=1			" コマンドラインの高さ
set previewheight=5		" プレビューウィンドウの高さ
set splitbelow			 " 横分割したら新しいウィンドウは下に
set splitright			 " 縦分割したら新しいウィンドウは右に
set guioptions-=rl  "スクロールバー非表示
"----------------------------------------------------------
" タブ
set showtabline=0  "タブを常に非表示
map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:


"ビジュアルモードの選択テキストをクリップボードにfor gvim
:set guioptions+=a

"-------------------------------------------------------------------------------
"プラグイン
"-------------------------------------------------------------------------------
" FuzzyFinder.vim
let g:FuzzyFinderOptions.MruFile.max_item = 1000
let g:FuzzyFinderOptions.MruCmd.max_item = 1000
nnoremap <Space>f f
nnoremap <Space>F F
nnoremap f <Nop>
nnoremap <silent> fb :<C-u>FuzzyFinderBuffer!<CR>
nnoremap <silent> ff :<C-u>FuzzyFinderMruFile<CR>
nnoremap <silent> fc :<C-u>FuzzyFinderMruCmd<CR>

"buftabs
:let g:buftabs_only_basename=1   " ファイル名のみを表示
:let g:buftabs_in_statusline=1   " ステータスラインに表示
:let g:buftabs_active_highlight_group="Visual" "現在のバッファをハイライト


