set nocompatible
set showmatch
set ignorecase
set mouse=v
set hlsearch
set incsearch
set filetype plugin on

" setup tabs
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set relativenumber
set number
set wildmode=longest,list
set cc=180
filetype plugin indent on
syntax on
set mouse=a
set clipboard=unnamedplus
set cursorline
set ttyfast

set timeout
set timeoutlen=2000
set updatetime =2000
inoremap jk <Esc>


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
    " Plugins
    Plug 'dracula/vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'mhinz/vim-startify'
    Plug 'scrooloose/nerdtree'
    Plug 'github/copilot.vim'
    Plug 'chrisbra/csv.vim'
call plug#end()

" setup colorscheme
syntax enable
colorscheme dracula

" setup keybindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

" Start NERDTree, unless a file or session is specified, eg. vim -S
" session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

