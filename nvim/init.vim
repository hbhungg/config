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

call plug#end()


" lua require('lspconfig')
lua require('lsp')
lua require('autocmp')

" Let tmux change its pane name base on vim file name
" That is currectly in focus
autocmd BufEnter,FileReadPost,BufNewFile,FocusGained * call system("tmux rename-window " . expand("%:t"))
" autocmd VimLeave * call system("tmux rename-window bash")

" Clean up when leaving vim
autocmd VimLeave * call system("tmux setw automatic-rename")

" Syntax highlighting
syntax on
color peachpuff
" Green comments
hi Comment ctermfg=darkgreen cterm=bold
" Better highlight word color
hi Search cterm=inverse ctermbg=black
hi Visual cterm=inverse ctermbg=black
" Cursor line highlight  
hi CursorLine cterm=underline

" Who the fuck think this is a good idea to auto comment on new line
set formatoptions-=cro

" Set vim clipboard to use system clipboard
set clipboard=unnamed

" Tab spacing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Starting to hate neovim abit
autocmd Filetype * setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set pumheight=2

set backspace=indent,eol,start
" Line numbers
set number
set autoindent
set laststatus=2
" Instant esc, uncomment if the esc feel slow but will probably cause by other stuff
set ttimeoutlen=10 timeoutlen=1000

" Yea might bite myself in the ass with this one
set noswapfile

" Better search highlight
set incsearch
set hlsearch

" Show normal mode command
set showcmd

" Split side
set splitbelow
set splitright

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
highlight CursorLine cterm=None
nnoremap <leader>c :set cursorline!<CR>
" Auto center when moving up and down
nnoremap <C-U> <C-U>zz
nnoremap <C-D> <C-D>zz
" Ctags jump
nnoremap <leader>] <C-W>]
