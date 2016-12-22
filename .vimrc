"Vundle配置
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"Add plugins by Plugin ... or Bundle ... for some older blowe
" 代码折叠
Plugin 'tmhedberg/SimpylFold'
"优化Python缩进"
"Plugin 'vim-scripts/indentpython.vim'
"Plugin 'klen/python-mode'
"自动完成"
Plugin 'Valloric/YouCompleteMe'
"代码检查与高亮"
Plugin 'scrooloose/syntastic'
"PEP8风格检查
Plugin 'nvie/vim-flake8'
"PEP8格式化
Plugin 'tell-k/vim-autopep8'
"配色方案"
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
"Git支持
Plugin 'tpope/vim-fugitive'
"树形目录
Plugin 'scrooloose/nerdtree'
"快速注释<Leader>c<space>
Plugin 'scrooloose/nerdcommenter'
"Sublime的Ctrl-p"
Plugin 'kien/ctrlp.vim'
"POWER Line 状态栏"
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Airline状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"End of Plugin list
call vundle#end()            " required
filetype plugin indent on    " required



"外观配置
"set nu

"选择配色方案
"if has('gui_running')
"  set background=dark
"    colorscheme solarized
"else
"    colorscheme Zenburn
"endif

let g:airline_theme="luna"
set laststatus=2    "always show the statusline
"使用Powerline字体,ee乱码
"let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

"Color scheme
"USe 256bit Color
set t_Co=256
"color wombat256mod

"Python 高亮优化
let python_highlight_all=1
syntax on
" Enable folding 开启代码折叠//热键za
set foldmethod=indent   "按缩进折叠"
set foldlevel=99"
" Enable folding with the spacebar//使用空格折叠
nnoremap f za
"开启折叠预览
let g:SimpylFold_docstring_preview=1
set nofoldenable



"按键配置

"Rebind <leader> key
let mapleader = " "

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 
set fileformat=unix

"AutoPEP8 配置
let g:autopip8_disable_show_diff=1

"Index for Full Stack前端缩进
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
set encoding=utf-8 |
"Showing length
set number     "show line numbers
set tw=79      "width of length
"set nowarp     "don't automattically wrap on load
set fo-=t      "don't automattically warp text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233  "grey line at right
let g:ctrlp_max_height = 30
set wildignore+=*.pyc               "ignore somefile on ctrlp list
set wildignore+=*_build/*
set wildignore+=*/coverage/*

"set history reg bigger
set history=700
set undolevels=700

"标示行末空白字符
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" highlight tabs and trailing spaces
"set listchars=tab:>-,trail:-
"set list

" save using F12
map <F12> :up<CR>
map <C-F12> :x!<CR>
imap <F12> <Esc><F12><CR>
imap <C-F12> <Esc><C-F12>

" move line up or dn
imap <C-d> <Esc>yyp
map <C-up> <up>ddp<up>
map <c-down> ddp
imap <C-up> <Esc><c-up>
imap <C-down> <Esc>ddp
imap <C-BS> <Esc>db

"comband select line to one  /using in css js ect.
vmap Q gq
nmap Q gqap

"auto read & write
set autoread
set autowrite

"Don't use swap file    
"If you edit a file from diff terminal it will useful
"set nobackup
"set nowirtebackup
"set noswapfile

"better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

"Mouse and backspace
set mouse=a "Mouse on whit Alt and click"
"set bs=2    "BackSpace to del on insert mode (default)

"Search Seting
"Remove highlight Of last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>
set hlsearch
set incsearch   "show match while typing
set ignorecase  "ignorecase search by default
set smartcase   "do not ignorecase when pattrn have Upcase

""map sort function
vnoremap <Leader>s :sort<CR>

"括号配对
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction


"multi display & moving
set splitbelow
set splitright
"使用C-hjkl切换布局
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"create new tab
nnoremap <Leader>t <esc>tabnew<CR>

"easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

map <Leader>e <esc>:e.<CR>

"run python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
