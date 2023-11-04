" =============================================
" Basic settings
" =============================================
syntax on
filetype plugin indent on
set autoindent
set expandtab
set shiftwidth=4
set backspace=2
set number
set wildmenu
set wildmode=list:longest,full
set hlsearch
set clipboard=unnamed,unnamedplus
set nowrap

" =============================================
" Colors and Appearance
" =============================================
colorscheme murphy
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 
highlight TabLineSel guifg=white guibg=blue
highlight TabLineSel ctermfg=white ctermbg=blue

" =============================================
" Key mappings
" =============================================
let mapleader = "\<space>"
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>
nnoremap <Tab> :wincmd w<CR>

" 新規タブでターミナルモードを起動
nnoremap <silent> tt <cmd>terminal<CR>
" 下分割でターミナルモードを起動
nnoremap <silent> tx <cmd>belowright new<CR><cmd>terminal<CR>

" =============================================
" Plugins
" =============================================
call plug#begin()
    Plug 'tpope/vim-vinegar'
    Plug 'mileszs/ack.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-fugitive'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'vim-airline/vim-airline'
    Plug 'kristijanhusak/defx-icons'
    Plug 'ryanoasis/vim-devicons'
    Plug 'kristijanhusak/defx-git'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'stephpy/vim-php-cs-fixer'
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/defx.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
call plug#end()

" =============================================
" Plugin-specific settings
" =============================================
let g:php_cs_fixer_path = '/usr/local/bin/php-cs-fixer'
let g:php_cs_fixer_enable_auto = 1

" =============================================
" Functions
" =============================================
function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('drop','tabnew')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('drop', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
endfunction

" =============================================
" Autocommands
" =============================================

" Neovimが起動したときにDefx起動
autocmd VimEnter * execute 'Defx'

autocmd FileType defx call s:defx_my_settings()
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

" ターミナルを開いたらに常にinsertモードに入る
autocmd TermOpen * :resize 10 | :startinsert

" vimの外でファイル更新・削除が入っても反映されるようにしておく
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()
" =============================================
" Other settings
" =============================================
packloadall
silent! helptags ALL

" vim-plug installation check
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Defx settings
call defx#custom#option('_', {
  \ 'winwidth': 30,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 1,
  \ 'buffer_name': 'exproler',
  \ 'toggle': 1,
  \ 'resume': 1,
  \ 'columns': 'indent:icons:filename:mark',
  \ })

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

" useの補完
nmap <silent><Leader>u      :<C-u>call phpactor#UseAdd()<CR>
" コンテキストメニューの起動(カーソル下のクラスやメンバに対して実行可能な選択肢を表示してくれます)
nmap <silent><Leader>mm     :<C-u>call phpactor#ContextMenu()<CR>
" ナビゲーションメニューの起動(クラスの参照元を列挙したり、他ファイルへのジャンプなど)
nmap <silent><Leader>nn     :<C-u>call phpactor#Navigate()<CR>
" カーソル下のクラスやメンバの定義元にジャンプ
nmap <silent><Leader>o      :<C-u>call phpactor#GotoDefinition()<CR>
" 編集中のクラスに対し各種の変更を加える(コンストラクタ補完、インタフェース実装など)
nmap <silent><Leader>tt     :<C-u>call phpactor#Transform()<CR>
" 新しいクラスを生成する(編集中のファイルに)
nmap <silent><Leader>cc     :<C-u>call phpactor#ClassNew()<CR>
" 選択した範囲を変数に抽出する
nmap <silent><Leader>ee     :<C-u>call phpactor#ExtractExpression(v:false)<CR>
" 選択した範囲を変数に抽出する
vmap <silent><Leader>ee     :<C-u>call phpactor#ExtractExpression(v:true)<CR>
" 選択した範囲を新たなメソッドとして抽出する
vmap <silent><Leader>em     :<C-u>call phpactor#ExtractMethod()<CR>
" split → jump
nmap <silent><C-w><Leader>o :<C-u>call DefinitionJumpWithPhpactor()<CR>
" カーソル下のクラスや変数の情報を表示する
" 他のエディタで、マウスカーソルをおいたときに表示されるポップアップなどに相当
vmap <silent><Leader>hh     :<C-u>call phpactor#Hover()<CR>

" =============================================
" ターミナルモードのキーマップ
" =============================================
tnoremap <ESC> <C-\><C-n>
tnoremap <C-W>n       <cmd>new<cr>
tnoremap <C-W><C-N>   <cmd>new<cr>
tnoremap <C-W>q       <cmd>quit<cr>
tnoremap <C-W><C-Q>   <cmd>quit<cr>
tnoremap <C-W>c       <cmd>close<cr>
tnoremap <C-W>o       <cmd>only<cr>
tnoremap <C-W><C-O>   <cmd>only<cr>
tnoremap <C-W><Down>  <cmd>wincmd j<cr>
tnoremap <C-W><C-J>   <cmd>wincmd j<cr>
tnoremap <C-W>j       <cmd>wincmd j<cr>
tnoremap <C-W><Up>    <cmd>wincmd k<cr>
tnoremap <C-W><C-K>   <cmd>wincmd k<cr>
tnoremap <C-W>k       <cmd>wincmd k<cr>
tnoremap <C-W><Left>  <cmd>wincmd h<cr>
tnoremap <C-W><C-H>   <cmd>wincmd h<cr>
tnoremap <C-W><BS>    <cmd>wincmd h<cr>
tnoremap <C-W>h       <cmd>wincmd h<cr>
tnoremap <C-W><Right> <cmd>wincmd l<cr>
tnoremap <C-W><C-L>   <cmd>wincmd l<cr>
tnoremap <C-W>l       <cmd>wincmd l<cr>
tnoremap <C-W>w       <cmd>wincmd w<cr>
tnoremap <C-W><C-W>   <cmd>wincmd w<cr>
tnoremap <C-W>W       <cmd>wincmd W<cr>
tnoremap <C-W>t       <cmd>wincmd t<cr>
tnoremap <C-W><C-T>   <cmd>wincmd t<cr>
tnoremap <C-W>b       <cmd>wincmd b<cr>
tnoremap <C-W><C-B>   <cmd>wincmd b<cr>
tnoremap <C-W>p       <cmd>wincmd p<cr>
tnoremap <C-W><C-P>   <cmd>wincmd p<cr>
tnoremap <C-W>P       <cmd>wincmd P<cr>
tnoremap <C-W>r       <cmd>wincmd r<cr>
tnoremap <C-W><C-R>   <cmd>wincmd r<cr>
tnoremap <C-W>R       <cmd>wincmd R<cr>
tnoremap <C-W>x       <cmd>wincmd x<cr>
tnoremap <C-W><C-X>   <cmd>wincmd x<cr>
tnoremap <C-W>K       <cmd>wincmd K<cr>
tnoremap <C-W>J       <cmd>wincmd J<cr>
tnoremap <C-W>H       <cmd>wincmd H<cr>
tnoremap <C-W>L       <cmd>wincmd L<cr>
tnoremap <C-W>T       <cmd>wincmd T<cr>
tnoremap <C-W>=       <cmd>wincmd =<cr>
tnoremap <C-W>-       <cmd>wincmd -<cr>
tnoremap <C-W>+       <cmd>wincmd +<cr>
tnoremap <C-W>z       <cmd>pclose<cr>
tnoremap <C-W><C-Z>   <cmd>pclose<cr>

