
" -- basics --
" Don't try to be vi compatible
set nocompatible

" no .swp
set noswapfile

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show relative line numbers with absolute at cursor
set relativenumber
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=5


" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Color scheme settings
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1


" -- netrw options -- 
" Remove the banner at the top
let g:netrw_banner = 0

" Tree view style
let g:netrw_liststyle = 3

" open in new tab
let g:netrw_browse_split = 3


" -- remaps -- 

" nicer search
nnoremap / /\v
vnoremap / /\v

let mapleader = " "
" leader-y for yanking to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" leader-p for pasting from  clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" next and previous tab
nnoremap gn :tabnext<CR>
nnoremap gp :tabprevious<CR>

" space-f for ex
nnoremap <leader>f :Explore<CR>
" use space-q to exit ex
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw nmap <buffer> <leader>q :bd<CR>
augroup END
