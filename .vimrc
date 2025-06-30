set nocompatible
set showmatch
set ignorecase
set mouse=v
set hlsearch
set incsearch
filetype on
filetype plugin on
filetype indent on

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

call plug#begin()
    " Plugins
    Plug 'morhetz/gruvbox'

call plug#end()

" LSP config
let g:LanguageClient_serverCommands= { 'cpp': ['clangd'], 'c': ['clangd'], 'python': ['pyright'] }

" Colorscheme
autocmd VimEnter * ++nested colorscheme gruvbox