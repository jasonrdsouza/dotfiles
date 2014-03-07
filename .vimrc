" Necessary to use fish shell
set shell=bash

" Vundle stuff
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'mileszs/ack.vim'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'JuliaLang/julia-vim'

" Tabs and spaces
set softtabstop=2              " soft tabs = 2 spaces
set tabstop=2                  " tabs = 2 spaces
set shiftwidth=2               " round indent actions to multiples of 2
set expandtab                  " expand tabs to spaces

" Searching
set hlsearch                   " highlight search terms
set incsearch                  " do incremental searching
set ignorecase                 " case insensitive searching
set smartcase                  " search upper/ all cases intelligently
set showmatch                  " show matching parenthesis

" Misc
set wildmenu                   " enhanced command line completion
set number                     " enable line numbers
set showmode                   " so you know what mode you are in
set autoread                   " reload files when changed on disk
syntax on                      " enable syntax highlighting
set clipboard=unnamed          " allow copy/pasting from system clipboard
filetype plugin indent on      " enable file type detection
set mouse=a                    " enable the mouse
set encoding=utf-8
set autoindent 
set smartindent
set list                       " show trailing whitespace
set listchars=tab:▸\ ,trail:▫

" Colors & Themeing
set t_Co=256                   " use 256 colors
set background=dark
colorscheme bubblegum

" Leader Key
let mapleader = ','

" Airline
set laststatus=2               " Always show statuslinee
set noshowmode                 " Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline_powerline_fonts=1
let g:airline_theme='dark'

" NERDTree
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" CtrlP
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader><space> :CtrlPMRUFiles<CR>
nmap <leader>t :CtrlP<CR>
" CtrlP Configs
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jar,*.gif,*.jpg,*.png,*.svg,*.ico,*.gz

" GVim stuff
if has("gui_running")
  " GUI is running or is about to start.
  set lines=40 columns=100
  colorscheme solarized
  set guifont=Ubuntu\ Mono\ derivative\ Powerline:h16
endif

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Alias tabbing to reselect text
vmap > >gv
vmap < <gv

" Easier moving around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Disable arrow keys to better GROK vim
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

noremap j gj
noremap k gk
