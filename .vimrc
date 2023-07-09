syntax on
filetype plugin indent on
set autoindent
set expandtab
set shiftwidth=4
set backspace=2
colorscheme murphy
set number
set wildmenu " Tabによる自動補完を有効にする
set wildmode=list:longest,full " 最長マッチまで補完してから自動補完メニューを開く
set hlsearch
set clipboard=unnamed,unnamedplus " システムのクリップボードにコピー

" vim-plugでプラグインを管理する
call plug#begin()
Plug 'tpope/vim-vinegar'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
call plug#end()
" すべてのファイルについて永続アンドゥを有効にする
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

packloadall " すべてのプラグインをロードする
silent! helptags ALL " すべてのプラグイン用にヘルプファイルをロードする

" ctrlキーとhjklで分割されたウィンドウ間を移動する
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

let &t_SI = "\<Esc>]50;CursorShape=1\x7" "インサートモードに入る時はカーソルを縦棒にする
let &t_EI = "\<Esc>]50;CursorShape=0\x7" "インサートモード終了時には、カーソルをブロックに戻す

let NERDTreehijackNetrw = 0 " NERDTreeの代わりにNetrwを使う

" Vim起動時にNERDTreeを開く
" autocmd VimEnter * NERDTree

" NERDTreeのウィンドウしかない時は自動的に閉じる
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" vim-plugがまだインストールされていなければインストールする
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autolaod/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
