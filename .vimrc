" ===========================
"          Плагины
" ===========================
call plug#begin() " Между этих строк добавлять плагины для установки.

" Функционал
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'} " AutoComplete

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
"       Настройка темы
" ============================
set background=dark " Тёмная тема
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'onehalfdark',
  \ }

colorscheme onedark

let g:onedark_termcolors=256

" ============================
"          Функции
" ============================

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


" ============================
"       Автокоманды
" ============================
augroup SetBackgroundAtStart
    au!
    au VimEnter * call BGToggleTransparency() " Прозрачный фон при входе
augroup END


" ===========================
"          Клавиши
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

" Autocomplete
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"


" ===========================
"     Основные настройки
" ===========================

" Кодировка
set encoding=utf-8             " Устанавливаем кодировку UTF-8
set fileencodings=utf-8        " Поддержка кодировки UTF-8 для файлов

set nocompatible               " Отключаем совместимость с vi
filetype plugin indent on      " Включаем поддержку плагинов

set scrolloff=5                " Отступ от края экрана при прокрутке
" set so=30                      " Курсор во время скроллинга будет всегда в середине экрана

" ====================================
"  Настройки отображения, Внешний вид
" ====================================
set relativenumber             " Включаем относительную нумерацию строк
set number                     " Включаем абсолютную нумерацию для текущей строки
set numberwidth=1              " Ширина номера строки

set cursorline

syntax on " Включаем подсветку синтаксиса

" Автодоболнения в command-mode
set wildmode=longest,list,full
set wildmenu

highlight LineNr ctermfg=NONE guifg=NONE  " Отключаем цвет для номеров строк
" highlight CursorLineNr ctermfg=NONE guifg=NONE  " Отключаем цвет для текущего номера строки

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
" set clipboard=unnamedplus

" ======================================================================
"      Настройка плагинов
" ============================

" добавляние пробела при коммунтировании (NerdCommenter)
let g:NERDSpaceDelims = 1

"    Настройка NerdTree

" Автоматическое открытие NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | wincmd p

" Юникодные иконки папок (Работает только с плагином vim-devicons)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" Показывает количество строк в файлах
let g:NERDTreeFileLines = 1
" Игнорировать указанные папки
let g:NERDTreeIgnore = ['^node_modules$', '^__pycache__$', '^.git$', '^.buildozer$']
" Закрыть vim, если единственная вкладка - это NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


"    Coc.nvim (Автодоболнения)

" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>aa  <Plug>(coc-codeaction-selected)
nmap <leader>aa  <Plug>(coc-codeaction-selected)

" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>rr  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>rr  <Plug>(coc-codeaction-refactor-selected)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" ======================================================================
