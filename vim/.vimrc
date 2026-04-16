" <Leader> set to <space>
let mapleader = " "
let maplocalleader = " "

" Basic options
set number
set relativenumber
set mouse=a

" set noundofile
silent !mkdir -p ~/.vim/undodir
set undodir=~/.vim/undodir
set undofile

set clipboard=unnamedplus
set clipboard=unnamed
set breakindent
set ignorecase
set smartcase
set signcolumn=yes
set updatetime=250
set timeoutlen=300
set splitright
set splitbelow
set list
set listchars=tab:»\ ,trail:·,nbsp:␣
set cursorline
set scrolloff=10
set confirm

tnoremap <Esc><Esc> <C-\><C-n>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>bn :enew<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <Esc> :nohlsearch<CR>

syntax on
colorscheme slate

" Yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" 1 Blinking Block
" 2 2 Solid Block
" 3 Blinking Underline
" 4 Solid Underline
" 5 Blinking Vertical Bar
" 6 Solid Vertical Bar
let &t_SI = "\e[5 q" " Insert mode (line)
let &t_SR = "\e[3 q" " Replace mode (underline)
let &t_EI = "\e[1 q" " Normal mode (block)
