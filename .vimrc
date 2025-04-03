
" -- basics --
" Don't try to be vi compatible
set nocompatible

" no .swp
set noswapfile

" auto reload
set autoread
au FocusGained,BufEnter * :checktime

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
set smartindent
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" wrap
set nowrap

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

" -- custom cmds --
" Create the Fmt command
command! Fmt call FormatFile()

" Function to format different filetypes (to be expanded)
function! FormatFile()
    let l:ft = &filetype
    if l:ft == 'python'
        let l:output = system('black ' . expand('%'))
    elseif l:ft == 'c' || l:ft == 'cpp'
        let l:output = system('clang-format -i ' . expand('%'))
    else
        echo "No formatter configured for filetype: " . l:ft
        return
    endif

    if v:shell_error
        echohl ErrorMsg
        echo "Formatting failed: " . l:output
        echohl None
        return
    endif
    edit!
endfunction

function! ToggleComment() range
    let l:comment_dict = {
        \ 'python': '#',
        \ 'sh': '#',
        \ 'bash': '#',
        \ 'vim': '"',
        \ 'c': '//',
        \ 'cpp': '//',
        \ 'java': '//',
        \ 'javascript': '//',
        \ 'typescript': '//',
        \ 'rust': '//',
        \ 'go': '//',
        \ 'lua': '--',
        \ 'sql': '--'
        \ }

    let l:ft = &filetype
    
    " Check if filetype is supported
    if !has_key(l:comment_dict, l:ft)
        echo "No comment style defined for filetype: " . l:ft
        return
    endif

    let l:comment = l:comment_dict[l:ft]
    
    " Check if the first line is already commented
    let l:firstline_content = getline(a:firstline)
    let l:is_commented = (l:firstline_content =~ '^\s*' . escape(l:comment, '/*+-.'))
    
    " Process each line in the range
    for l:line_num in range(a:firstline, a:lastline)
        let l:line = getline(l:line_num)
        
        if l:is_commented
            " Remove comment
            let l:new_line = substitute(l:line, '^\(\s*\)' . escape(l:comment, '/*+-.') . '\s\?', '\1', '')
        else
            " Add comment
            let l:new_line = substitute(l:line, '^\(\s*\)', '\1' . l:comment . ' ', '')
        endif
        
        call setline(l:line_num, l:new_line)
    endfor
endfunction



"  Ctrl-C for both normal and visual mode
nnoremap <C-c> :call ToggleComment()<CR>
vnoremap <C-c> :call ToggleComment()<CR>
