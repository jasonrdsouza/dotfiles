" Necessary to use fish shell
set shell=bash

" Vundle stuff
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Other plugins
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'mtth/scratch.vim'
Plugin 'tpope/vim-surround'
Plugin 'morhetz/gruvbox'
Plugin 'takac/vim-hardtime'
Plugin 'dart-lang/dart-vim-plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Tabs and spaces
set softtabstop=2              " soft tabs = 4 spaces
set tabstop=2                  " tabs = 4 spaces
set shiftwidth=2               " round indent actions to multiples of 4
set expandtab                  " expand tabs to spaces
set autoindent                 " Copy indent from current line
set smartindent
set list                       " show trailing whitespace
set listchars=tab:▸\ ,trail:▫

" Searching
set hlsearch                   " highlight search terms
set incsearch                  " do incremental searching
set ignorecase                 " case insensitive searching
set smartcase                  " search upper/ all cases intelligently
set showmatch                  " show matching parenthesis

" Undo Tree
set undofile
set undodir=~/.vim/undo
set undolevels=1000

" Misc
set wildmenu                   " enhanced command line completion
set wildmode=list:longest      " complete matches with longest common string
set number                     " enable line numbers
set relativenumber             " show relative line numbers
set showmode                   " so you know what mode you are in
set autoread                   " reload files when changed on disk
syntax on                      " enable syntax highlighting
set clipboard=unnamed          " allow copy/pasting from system clipboard
filetype plugin indent on      " enable file type detection
set mouse=a                    " enable the mouse
set encoding=utf-8
set hidden                     " allow unsaved buffers to be hidden
set history=1000               " Store 1000 previous history entries
set cursorline                 " Highlight the current line

" Leader Key
nnoremap <SPACE> <Nop>
let mapleader = ' '

" Quick vimrc access
nmap <leader>ev :e $MYVIMRC<cr>
nmap <leader>sv :so $MYVIMRC<cr>

" Colors & Themeing
set t_Co=256                   " use 256 colors
set background=dark
colorscheme solarized

" GVim stuff
if has("gui_running")
  " GUI is running or is about to start.
  set lines=40 columns=100
  set transparency=0
  set guifont=mononoki-Regular\ Nerd\ Font\ Complete\ Mono:h18
endif

" Airline
set laststatus=2               " Always show statuslinee
set noshowmode                 " Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline_left_sep = "\uE0BC"
let g:airline_right_sep = "\uE0BA"

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
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jar,*.gif,*.jpg,*.png,*.svg,*.ico,*.gz

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " Use ag instead of ack for grepping
  let g:ackprg = 'ag --vimgrep'
endif

" Ack.vim
" Remap \ to search the working directory using Ack.vim
nnoremap \ :Ack!<SPACE>

" Syntastic
let g:syntastic_python_checkers = ['pyflakes']

" Vim Hardtime
let g:hardtime_default_on = 0 " disallow repeated movement keypresses

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Alias tabbing to reselect text
vmap > >gv
vmap < <gv

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Easier moving around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

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

