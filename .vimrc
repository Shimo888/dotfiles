set number 
syntax enable

" 移動
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" タブ移動
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
nnoremap X :tabclose<CR>
" nmap C <Action>(workbench.action.reopenClosedEditor)

" タブ入れ替え
nnoremap < :tabmove -1<CR>
nnoremap > :tabmove +1<CR>

" ウィンドウ移動
nnoremap L <C-w>w
nnoremap H <C-w>W

" ウィンドウ分割
nnoremap zj :split<CR>
nnoremap zl :vsplit<CR>

" チャンク内容をクリップボードにコピーする 
set clipboard+=unnamedplus

" スクロールオフセット
set scrolloff=5

" インクリメンタルサーチ
set incsearch

" Ex モードを使わず、Q をフォーマットに割り当て
map Q gq

" リーダーキー設定（半角スペース）
let mapleader = ' '