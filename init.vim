set shell=/bin/zsh
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
set number

syntax on 

call plug#begin()
    Plug 'ntk148v/vim-horizon'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'tyru/caw.vim'
call plug#end()

" if you don't set this option, this color might not correct
set termguicolors

colorscheme horizon
" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'horizon'
let g:gitgutter_highlight_lines = 1
