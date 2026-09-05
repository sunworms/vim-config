let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_spellfile_plugin = 1

set nocompatible
set termguicolors
filetype plugin indent on
syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set shiftround
set autoindent
set smartindent

set nobackup
set nowritebackup
set noswapfile

set hidden
set autoread

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set updatetime=100
set number
syntax on
let mapleader = ","

noremap <leader>v <C-w>v

vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap / /\v
vnoremap / /\v

noremap <leader><space> :noh<cr>:call clearmatches()<cr>

nnoremap <leader><leader> <c-^>

noremap j gj
noremap k gk
