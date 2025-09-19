" ========== Plugins ==========

call plug#begin()

" Functional
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()


" ========== Appearance ==========

set background=dark
set laststatus=2

let g:lightline = { 'colorscheme': 'catppuccin_frappe' }

colorscheme catppuccin_frappe

if exists('+termguicolors')
    let g:onedark_termcolors=256
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    set t_Co=256
endif

" Cursor style
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[2 q"
let &t_SR = "\<Esc>[4 q"


" ========== Main settings ==========

set encoding=utf-8
set fileencodings=utf-8

set nocompatible " Disable compatible with vi
filetype plugin indent on " Enable plugin support

set scrolloff=5 " Scroll offset from edge of screen
" set so=30 " Cursor always be in middle of screen when scrolling

set relativenumber
set number
set numberwidth=3

set cursorline

syntax on

" Autocomplete in command-mode
set wildmode=longest,list,full
set wildmenu

" Tabulation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set smartindent

set modelines=0  " Disable CVE-2007-2438 vulnerability

set backspace=indent,eol,start " More capability for delete text
set ruler " Show current cursor position
set mouse=a " Enable mouse

" Disable backups
set nobackup
set nowritebackup

set updatetime=300

set signcolumn=yes

" Search
set incsearch " Search as you type
set ignorecase " Ignore register
set smartcase " Ignore register if no capital letters

set clipboard=unnamedplus

" ========== Functions ==========

" Toggle background transparency
let t:isTransparent = 1
function! ToggleBGTransparency()
    if t:isTransparent == 0
        hi Normal guibg=#2E3440 ctermbg=black
        let t:isTransparent = 1
    else
        hi Normal guibg=NONE ctermbg=NONE
        let t:isTransparent = 0
    endif
endfunction

" Toggle word wrap
let t:isWordWrap = 1
function! ToggleWordWrap()
    if t:isWordWrap
        set nowrap
        let t:isWordWrap = 0
    else
        set wrap
        let t:isWordWrap = 1
    endif
endfunction


" ========== Autocommands ==========
au VimEnter * call ToggleBGTransparency() " Transparent background
au VimEnter * call ToggleWordWrap() " Disable wrap
au CmdlineEnter /,? set hlsearch " Enable hlsearch


" ========== Keys ==========

" Change leaders
let mapleader = " "
let maplocalleader = "\\"

nnoremap <Esc> <cmd> set nohlsearch <CR>

nnoremap <leader>E <cmd> NERDTreeClose <CR>
nnoremap <leader>e <cmd> NERDTreeFocus <CR>

nnoremap <leader>sb :call ToggleBGTransparency()<CR>
nnoremap <leader>ss :call ToggleSearchHilighting()<CR>
nnoremap <leader>sw :call ToggleWordWrap()<CR>
nnoremap <leader>ss :setlocal spell!<CR>

" nnoremap <C-D> <C-D>zz
" nnoremap <C-U> <C-U>zz

nnoremap <leader>w :wa<CR>

nnoremap <localleader>y "+y
vnoremap <localleader>y "+y

" ========== Plugins settings ==========

" - NERDCommenter
let g:NERDSpaceDelims = 1

" - DevIcons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" - NERDTree

" Automatic open NERDTree at enter
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | wincmd p

" Exit if only tab is NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeFileLines = 1
let g:NERDTreeIgnore = ['^.git$', '^__pycache__$', '^.venv$', '^node_modules$', '^.ruff_cache$']


" ========== Change Highlight ==========

" highlight LineNr ctermfg=NONE guifg=NONE  " Disable color for line number
" highlight CursorLineNr ctermfg=NONE guifg=NONE  " Disable color for current line number
highlight SignColumn ctermbg=NONE guibg=NONE

