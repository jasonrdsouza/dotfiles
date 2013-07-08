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
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'bling/vim-airline'

set softtabstop=2              " soft tabs = 2 spaces 
set tabstop=2                  " tabs = 2 spaces
set shiftwidth=2               " round indent actions to multiples of 2

set expandtab                  " expand tabs to spaces
set number          		       " enable line numbers
set showmode                   " so you know what mode you are in

set hlsearch                   " highlight search terms
set incsearch                  " do incremental searching

set smartcase                  " search upper/ all cases intelligently
set showmatch                  " shoq matching parenthesis
set wildmenu                   " enhanced command line completion

syntax on                      " enable syntax highlighting
set clipboard=unnamed          " allow copy/pasting from system clipboard
filetype plugin indent on      " enable file type detection
set mouse=a                    " enable the mouse

set t_Co=256                   " use 256 colors
"set background=dark
colorscheme bubblegum

set autoindent smartindent

" Airline
set laststatus=2               " Always show statuslinee
set noshowmode                 " Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline_powerline_fonts=1
let g:airline_theme='dark'

" CtrlP
map <c-b> <ESC>:CtrlPBuffer<CR>
map <c-Space> <ESC>:CtrlPMRUFiles<CR>

" Default GVim size
if has("gui_running")
  " GUI is running or is about to start.
  set lines=60 columns=200
endif

" Alias tabbing to reselect text 
vmap > >gv
vmap < <gv

