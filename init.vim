call plug#begin()
  Plug 'sbdchd/neoformat'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neovimhaskell/haskell-vim'
  Plug 'wakatime/vim-wakatime'
  Plug 'plasticboy/vim-markdown'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'itchyny/lightline.vim'
call plug#end()

syntax on
set noerrorbells

filetype plugin indent on
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set number                                                                               

" set colorcolumn=80 "
highlight ColorColum ctermbg=0 guibg=lightgrey


colorscheme palenight
set background=dark
imap <F8> :NeoFormatinoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

" COC mappings "
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
