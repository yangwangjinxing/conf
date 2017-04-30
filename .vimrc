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
"Fcitx key
Plugin 'lilydjwg/fcitx.vim'
"自动完成"
Plugin 'Valloric/YouCompleteMe'
" Snips(改变Tab键行为)
Plugin 'SirVer/ultisnips'
" SnipsLib
Plugin 'honza/vim-snippets'
"Plugin 'Psycojoker/UltiSnips'
" 多个插件 Tab 共享
"Plugin 'ervandew/supertab'
"多重选取
Plugin 'terryma/vim-multiple-cursors'
"Emmet
Plugin 'mattn/emmet-vim'
"括号匹配
Plugin 'Raimondi/delimitMate'
"环绕符号(套括号,引号)
"Plugin 'tpope/vim-surround'
"代码检查与高亮"
"Plugin 'scrooloose/syntastic'
" Jinja代码高亮
Plugin 'Glench/Vim-Jinja2-Syntax'
"python实时代码检查
Plugin 'kevinw/pyflakes-vim'
"PEP8风格检查
Plugin 'nvie/vim-flake8'
"PEP8格式化
Plugin 'tell-k/vim-autopep8'
"配色方案"
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
"Git支持(不常用)
"Plugin 'tpope/vim-fugitive'
" markdown 实时预览
Plugin 'iamcco/markdown-preview.vim'
Plugin 'iamcco/mathjax-support-for-mkdp'
"Youdao 划词翻译
Plugin 'iamcco/dict.vim'
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


set term=xterm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Apearance                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" Enable folding with the spacebar//使用f折叠
"nnoremap f za
"开启折叠预览
let g:SimpylFold_docstring_preview=1
set nofoldenable



"按键配置

"Rebind <leader> key
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Autocomplete                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"YouCompleteMe 配置
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"配置python路径,以支持跳转到头文件
let g:ycm_python_binary_path = '/usr/bin/python3'
"更改列表选择快捷键
"let g:ycm_key_list_select_completion = [‘<c-n>‘, ‘<Down>‘]
"let g:ycm_key_list_previous_completion = [‘<c-p>‘, ‘<Up>‘]
"AutoFix Alt-f
nnoremap <S-f> :YcmCompleter FixIt<CR>

"UltiSnips 配置
"let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"使jinjia的snips在html文档中启用
autocmd FileType html UltiSnipsAddFiletypes jinja

" 解决YCM UltiSnips冲突
" 效果:<Tab>在YCM列表中当前高亮为Snips时触发Snips否则跳到下一条
" 使用方向键移动关标不触发snips
" 参考:http://blog.csdn.net/qq_20336817/article/details/51115411
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Code Standard                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"AutoPEP8 配置
let g:autopip8_disable_show_diff=1

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 
set fileformat=unix

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
highlight ColorColumn ctermbg=23  "grey line at right
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Translate                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--普通模式下，<Leader>d 即可翻译光标下的文本，并在命令行回显
nmap <silent> <Leader>d <Plug>DictSearch

"--可视化模式下，<Leader>d 即可翻译选中的文本，并在命令行回显
vmap <silent> <Leader>d <Plug>DictVSearch

"--普通模式下，<Leader><Leader>d 即可翻译光标下的文本，并且在Dict新窗口显示
nmap <Leader><Leader>d <Plug>DictWSearch
"--可视化模式下，<Leader><Leader>d 即可翻译选中的文本，并且在Dict新窗口显示
vmap <Leader><Leader>d <Plug>DictWVSearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Custom Shortcut                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" save using F12
noremap <F12> :up<CR>
noremap <C-F12> :x!<CR>
imap <F12> <Esc><F12>
imap <C-F12> <Esc><C-F12>
" exit without save
nnoremap <M-F12> <Esc>:q!<CR>
imap <M-F12> <Esc><M-F12>


" move line up or dn
imap <C-d> <Esc>yyp
map <C-up> <up>ddp<up>
map <c-down> ddp
imap <C-up> <Esc><c-up>
imap <C-down> <Esc>ddp
imap <C-BS> <Esc>db
imap <C-v>  <Esc>l<C-v>

"better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed
inoremap <Home> <C-r>=Home('i')<CR>
inoremap <kHome> <C-r>=Home('i')<CR>
nnoremap <kHome> i<C-r>=Home('n')<CR>
nnoremap <Home> i<C-r>=Home('n')<CR>

"make <Home> switch between begin and first not empty char
function! Home(mod)
    let a:unempty=0
    let a:gl=getline('.')
    for i in range(0,col('.')-2)
        let a:unempty+= a:gl[i]!=' ' && a:gl[i]!='\t'
    endfor
    if a:unempty || col('.')==1
        return a:mod=='i' ? "\<esc>^": "\<esc>^i"
    else
        return a:mod=='i' ? "\<esc>\<home>i" : "\<esc>\<home>"
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Buffer                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"comband select line to one  /using in css js ect.
vmap Q gq
nmap Q gqap

"auto read & write
set autoread
set autowrite

"Don't use swap file    
"If you edit a file from diff terminal it will useful
set nobackup
"set nowirtebackup
set noswapfile

"Mouse and backspace
set mouse=a "Mouse on whit Alt and click"
"set bs=2    "BackSpace to del on insert mode (default)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Search Seting                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove highlight Of last search
noremap <C-\> :nohl<CR>
vnoremap <C-\> <Esc>:nohl<CR>
inoremap <C-\> <ESC>:nohl<CR>
set hlsearch
set incsearch   "show match while typing
set ignorecase  "ignorecase search by default
set smartcase   "do not ignorecase when pattrn have Upcase


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Sort                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <Leader>s :sort<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Comment                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <C-c> <Leader>c<space>
nmap <C-c> <Leader>c<space>
imap <C-c> <Esc><Leader>c<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Emmet                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Help https://www.zfanw.com/blog/zencoding-vim-tutorial-chinese.html
" Enable in different mode
"nonly enable (n)ormal mode functions.
"enable all functions, which is equal to(inv)
"enable all function in (a)ll mode.
let g:user_emmet_mode='n'    
let g:user_emmet_leader_key='<C-y>'
" Enable just for html/css
let g:user_emmet_install_global = 1
"autocmd FileType html,css EmmetInstall
imap <C-e> <Esc><C-y>,

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  MarkDown                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd filetype md map <silent> <F8> <Plug>MarkdownPreview        " for normal mode
autocmd filetype md imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
autocmd filetype md nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
autocmd filetype md imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Layout                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
map <Leader>t <esc>:tabnew<CR>
"close the tab
map <Leader>w <esc>:tabclose<CR>
"open the exprole
map <Leader>e <esc>:e.<CR>
"Leader [n,m] were disable please use C-A-[Up,Dn] to shitch tab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Running                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"<F4> to debug ,<F5> to run
autocmd filetype python nnoremap <F5> :up <bar> exec '!python3 '.shellescape('%')<CR>
autocmd filetype python imap <F5> <Esc><F5>

autocmd filetype c nnoremap <F5> :up <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype c nnoremap <F4> :up <bar> :!gcc % -g -o `basename % .c` && gdb `basename % .c`<CR>
autocmd filetype c imap <F5> <Esc><F5>
autocmd filetype c imap <F4> <Esc><F4>

autocmd filetype cpp nnoremap <F5> :up <bar> exec '!g++ -std=c++11 '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F4> :up <bar> :!g++ -std=c++11 % -g -o `basename % .cpp` && gdb `basename % .cpp` <CR>
autocmd filetype cpp imap <F5> <Esc><F5>
autocmd filetype cpp imap <F4> <Esc><F4>

autocmd filetype java nnoremap <F5> :up <bar> :!javac %; java `basename % .java`<CR>
autocmd filetype java imap <F5> <Esc><F5>

autocmd FileType sh nnoremap <F5> :up <bar> :!chmod +x % && ./%<CR>
autocmd FileType sh imap <F5> <Esc><F5>

