" Plugins
call plug#begin()
" LSP
Plug 'neovim/nvim-lspconfig'
" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
" Comment
Plug 'terrortylor/nvim-comment'
call plug#end()

lua require('lsp')
lua require('treesitter')
lua require('comment')

" Everything from down here does not required plugins
syntax on
color peachpuff

" Better highlight word color
hi Search ctermfg=Red ctermbg=LightYellow
hi Visual cterm=inverse ctermbg=black
" Cursor line highlight
hi CursorLine cterm=underline

" Set vim clipboard to use system clipboard
set clipboard=unnamed

" Global tab spacing on all filetype
autocmd Filetype * setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType * setlocal formatoptions-=cro
set autoindent

set pumheight=2

set backspace=indent,eol,start
" Line numbers, hybrid relative
set number relativenumber

" Status bar
set laststatus=1

" Seperator
set fillchars+=vert:\

" Instant esc, uncomment if the esc feel slow but will probably cause by other stuff
set ttimeoutlen=10 timeoutlen=1000

" Yea might bite myself in the ass with this one
set noswapfile

" Better search highlight
set incsearch
set hlsearch

" Show normal mode command (since ch=0 this would not work)
set showcmd

" Split side
set splitbelow
set splitright

" Is this overkill?
command! -bar -nargs=* -complete=file -range=% -bang W <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq <line1>,<line2>wq<bang> <args>

" Map leader
let mapleader="\<space>"
" Some keybindings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Better indenting while in visual and normal mode
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Work around for <C-i> since alacritty saw it as <tab>
nnoremap <C-n>i <C-i>
" Toggle cursor line highlight
nnoremap <leader>c :set cursorline!<CR>
" Auto center when moving up and down
nnoremap <C-U> <C-U>zz
nnoremap <C-D> <C-D>zz
" Ctags jump
nnoremap <leader>] <C-W>]
" Resize split
nnoremap <leader>= :exec "vertical resize ". (winwidth(0) * 7/6)<CR>
nnoremap <leader>- :exec "vertical resize ". (winwidth(0) * 6/7)<CR>
" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" Vim will boost your productivity they said...
nnoremap <leader>r :exec "source $MYVIMRC"<cr>
" Custom command
command! -range=% Dws <line1>,<line2>s/\s\+$//e
