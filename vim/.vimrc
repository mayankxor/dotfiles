""""" OPTIONS
set background=dark
set number
set relativenumber
set shortmess+=I
autocmd VimEnter * echo "Vim ready at " . strftime("%H:%M:%S")
let mapleader=" "
set noswapfile
set nobackup
set clipboard=unnamedplus

" STATUS LINE
hi StatusLine ctermbg=white ctermfg=black
hi StatusLineNC ctermbg=darkgrey ctermfg=black
set laststatus=2
set statusline=%t%m%r%=buf=%n\ ft=%{&ft}\ %l/%L:%c(%P)\ bo=%o\ format=%{&ff}\ enc=%{&fenc}

set incsearch
set mouse=a
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set wrap
set undofile
set ignorecase
set smartcase
let g:netrw_banner=0
set termguicolors
set scrolloff=3
set signcolumn=auto
set backspace=indent,eol,start
set splitright
set splitbelow
set isfname+=-
set updatetime=4000
set colorcolumn=80
set nocursorline
set hlsearch
set nolist
set confirm
set autoread
set fileignorecase
set noendofline
set noendofline
set mousehide
set shell=/usr/bin/zsh
set ruler
set smoothscroll
set timeout
set timeoutlen=1000
set notitle
syntax on
colorscheme industry
