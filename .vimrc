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
" colorscheme retrobox
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1


" -- netrw options -- 
" Remove the banner at the top
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

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

" -- custom cmds --
" Create the Fmt command
command! Fmt call FormatFile()

" Function to format different filetypes (to be expanded)
function! FormatFile()
    let l:ft = &filetype
    if l:ft == 'python'
        let l:output = system('uvx black ' . expand('%'))
    elseif l:ft == 'c' || l:ft == 'cpp'
        let l:output = system('clang-format -i ' . expand('%'))
    elseif l:ft == 'go'
        let l:output = system('go fmt ' . expand('%'))
    elseif l:ft == 'rust'
        let l:output = system('cargo fmt')
    elseif l:ft == 'typst'
        let l:output = system('typstyle -i ' . expand('%'))
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
        \ 'sql': '--',
        \ 'lisp': ';;'
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

set path+=**
set wildmenu

" -- LSP Configuration (Neovim only) --
if has('nvim')
    " Start a lua block
    lua << EOF
        -- Python Language Server (ruff)
        vim.lsp.config('pyright', {
          cmd = { 'pyright-langserver','--stdio' },
          filetypes = { 'python' },
          root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
                typeCheckingMode = 'basic', -- or 'strict'
                autoImportCompletions = true,
              },
            },
          },
        })
        vim.lsp.config('clangd', {
          cmd = { 'clangd' },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
          root_markers = {
            'compile_commands.json',
            'compile_flags.txt',
            '.clangd',
            '.git',
          },
        })

        
        vim.lsp.config('rust-analyzer', {
          cmd = { 'rust-analyzer' },
          filetypes = {'rust'},
          root_markers = { "Cargo.toml" },
          settings = {
            ["rust-analyzer"] = {
              --checkOnSave = {
              --  command = 'clippy', -- You can use 'check' or 'clippy'
              --},
            }
          },
        })
        vim.lsp.config('zls', {
          cmd = { 'zls' },
          filetypes = { 'zig' },
        })

        -- Enable the LSPs
        vim.lsp.enable('pyright')
        vim.lsp.enable('clangd')
        vim.lsp.enable('rust-analyzer')
        vim.lsp.enable('zls')

        -- Generic LSP setup options that apply to all servers
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                signs = true,
                update_in_insert = false,
            }
        )

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "single"
            }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = "single"
            }
        )
        local opts = { noremap=true, silent=true }

        -- keybinds (TODO: make proper)
        vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
EOF
endif

" vim.pack  plugins
if has('nvim')
    lua << EOF
    vim.pack.add({
      'https://github.com/nvim-lua/plenary.nvim'
    })
    vim.pack.add({
      'https://github.com/nvim-telescope/telescope.nvim'
    })
    vim.pack.add({
      'https://github.com/nvim-treesitter/nvim-treesitter'
    })

    vim.pack.add({
      'https://github.com/supermaven-inc/supermaven-nvim'
    })

    -- telescope setup
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })

    vim.filetype.add({ extension = { jl = "lisp" }, })
    vim.filetype.add({ extension = { hy = "lisp", }, })

    -- supermaven setup
    require('supermaven-nvim').setup({})
EOF
endif

inoremap <silent> <C-Space> <C-X><C-O>
