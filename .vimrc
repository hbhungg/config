set nocompatible
filetype off

" Fuzzy Find
set rtp+=~/.vim/bundle/fzf
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
call vundle#end()

" Something something YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion= 1
" No more autocomplete highlighting
let g:ycm_show_diagnostics_ui = 0

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

" Set vim clipboard to use system clipboard
set clipboard=unnamedplus

" Tab spacing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Line numbers
set number
set autoindent
set laststatus=1
" Instant esc, uncomment if the esc feel slow but will probably cause by other stuff
"set ttimeout
"set ttimeoutlen=10
"set timeoutlen=10

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
