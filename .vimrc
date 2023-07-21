syntax on
filetype plugin indent on
set autoindent
set expandtab
set shiftwidth=4
set backspace=2
colorscheme murphy
set number

set wildmenu
set wildmode=list:longest,full " 最長マッチまで補完してから自動補完メニューを開く
set hlsearch
set clipboard=unnamed,unnamedplus " システムのクリップボードにコピー

" Leaderキーをスペースに変更
let mapleader = "\<space>"

" vim-plugでプラグインを管理する
call plug#begin()
    Plug 'tpope/vim-vinegar'
    Plug 'mileszs/ack.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-fugitive'
    Plug 'christoomey/vim-tmux-navigator'
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

" let NERDTreehijackNetrw = 0 " NERDTreeの代わりにNetrwを使う

" Vim起動時にNERDTreeを開く
" autocmd VimEnter * NERDTree

" NERDTreeのウィンドウしかない時は自動的に閉じる
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-plugがまだインストールされていなければインストールする
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if &term =~ 'xterm\|rxvt'
  " インサートモードに入る時はカーソルを縦棒にする
  let &t_SI = "\<Esc>[5 q"
  " ノーマルモードに戻る時には、カーソルをブロックに戻す
  let &t_EI = "\<Esc>[2 q"
endif
