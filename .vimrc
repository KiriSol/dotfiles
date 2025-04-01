" ===========================
"          Плагины
" ===========================
call plug#begin()  " Между этих строк добавлять плагины для установки.

" Функционал
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'

" Красиво
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'

" Themes
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

" ============================
"      Настройка плагинов
" ============================



" ============================
"       Настройка темы
" ============================
set background=dark            " Тёмная тема
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'onehalfdark',
  \ }

colorscheme onedark

let g:onedark_termcolors=256
"let g:catppuccin_termcolors=256

" ==============
"    Функции
" ==============

" Включение/отключение прозрачного фона
let t:isTransparent = 1
function! BGToggleTransparency()
  if t:isTransparent == 0
    hi Normal guibg=#2E3440 ctermbg=blacK
    let t:isTransparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:isTransparent = 0
  endif
endfunction

" Отключение/включение подсветки поиска
let t:isSearchHilighting = 1
function! SearchToggleHilighting()
    if t:isSearchHilighting
        set nohlsearch
        let t:isSearchHilighting = 0
    else
        set hlsearch
        let t:isSearchHilighting = 1
    endif
endfunction


" ===============
"  Автокоманды
" ===============
augroup Start
    au!
    au VimEnter * call BGToggleTransparency() " Прозрачный фон при входе
augroup END


" Клавиши
" ===========================

" Изменяем leader
map <Space> <leader>

" Сочетание клавиш для переключения NERDTree
nnoremap <leader>r :NERDTreeClose<CR>
nnoremap <leader>e :NERDTreeFocus<CR>

" Клавиша для фона
nnoremap <leader>bg :call BGToggleTransparency()<CR>

" Сочетание клавиш для отключения/ подсветки поиска
nnoremap <leader>sh :call SearchToggleHilighting()<CR>

" Включить/выключить проверку орфографии
nnoremap <leader>ss :setlocal spell!<CR>

" Прокрутка + центрирование
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" Сохранение файла
nnoremap <C-s> :wa<CR>

" Сочетание клавиш для копирования в системный буфер обмена
nnoremap <leader>y "+y
vnoremap <leader>y "+y


" Не планируется редактировать
" ===============================================================================================

" Настройка NerdTree
" ==========================
" Юникодные иконки папок (Работает только с плагином vim-devicons)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" Показывает количество строк в файлах
let g:NERDTreeFileLines = 1
" Игнорировать указанные папки
let g:NERDTreeIgnore = ['^node_modules$', '^__pycache__$', '^.git$', '^.buildozer$']
" Закрыть vim, если единственная вкладка - это NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" ===========================
"     Основные настройки
" ===========================

" Кодировка
set encoding=utf-8             " Устанавливаем кодировку UTF-8
set fileencodings=utf-8        " Поддержка кодировки UTF-8 для файлов

set nocompatible               " Отключаем совместимость с vi
filetype plugin indent on      " Включаем поддержку плагинов

set scrolloff=5                " Отступ от края экрана при прокрутке


" ====================================
"  Настройки отображения, Внешний вид
" ====================================
set relativenumber             " Включаем относительную нумерацию строк
set number                     " Включаем абсолютную нумерацию для текущей строки
set numberwidth=1              " Ширина номера строки

set cursorline

syntax on " Включаем подсветку синтаксиса

" Автодоболнения в command-mode
"set rnu nu
set wildmode=longest,list,full
set wildmenu

highlight LineNr ctermfg=NONE guifg=NONE  " Отключаем цвет для номеров строк
"highlight CursorLineNr ctermfg=NONE guifg=NONE  " Отключаем цвет для текущего номера строки

" ======================
"  Отображеие TrueColor
" ======================
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set t_Co=256

" Стиль курсора
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[2 q"
let &t_SR = "\<Esc>[4 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup SetCursorAtEnter
    au!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" ==============================

" ===========================
"     Настройки табуляции
" ===========================
set expandtab                  " Заменяем табуляции на пробелы
set tabstop=4                  " Количество пробелов для табуляции
set shiftwidth=4               " Количество пробелов при автодобавлении отступов
set softtabstop=4              " Количество пробелов при автотабуляции

set smarttab                   " Умное поведение табуляции
set smartindent                " Умное выравнивание для кода

" ===========================
"       Безопасность
" ===========================
set modelines=0     " Отключаем CVE-2007-2438 уязвимость

" ===========================
"     Производительность
" ===========================
set backspace=indent,eol,start " Больше возможностей для удаления текста
set nowrap                     " Отключаем перенос строк
set ruler                      " Показывать текущие координаты курсора
set mouse=a                    " Включаем поддержку мыши

" ===========================
"        Автокоманды
" ===========================
" Не создавать резервные копии для crontab и chpass
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" ===========================
"           Поиск
" ===========================
set hlsearch                   " Включаем подсветку поиска
set incsearch                  " Поиск по мере ввода
set ic                         " Игнорировать регистр при поиске (set ignorecase)
set smartcase                  " Игнорировать регистр, если нет заглавных букв

" Буфер обмена
"set clipboard=unnamedplus

" Autocomplete
"inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

