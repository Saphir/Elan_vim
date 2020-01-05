" Elan vim
"
"
"
"

"==========================================
" General Settings
"==========================================
set history=200
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

"set cursorcolumn
"set cursorline
" hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
hi CursorColumn ctermfg=None ctermbg=237 cterm=None guifg=white guibg=#3c3d37 gui=None
" hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE

set nobackup
set noswapfile

color desert256
" set scrolloff=2
set belloff=all

set wildignore=*.swp,*.bak,*.pyc,*.class,.svn
set mouse=n
set selection=inclusive
set selectmode=mouse,key

set title
set noerrorbells
set t_vb=
set tm=500

set magic

set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set wrap
" set ruler

set laststatus=2
set showmatch

set hlsearch
set incsearch
set ignorecase
set smartcase

set foldenable
set foldmethod=indent
set foldlevel=99

set smartindent
set autoindent

set tabstop=4
set softtabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
autocmd FileType make set noexpandtab
autocmd BufLeave *.{c,cpp} mark C
autocmd BufLeave *.h       mark H
set shiftround

"remember last update or view postion"
" Only do this part when compiled with support for autocommands
if has("autocmd")
" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif
endif

let mapleader = ';'
let g:mapleader = ';'

nmap <leader>q :bd<CR>

map <leader>qq :qa!<CR>
imap <leader>qq <ESC>:qa!<CR>
vmap <leader>qq <ESC>:qa!<CR>

map <leader>S :wqa!<CR>
imap <leader>S <ESC>:wqa!<CR>
vmap <leader>S <ESC>:wqa!<CR>

map <leader>s :w<CR>
imap <leader>s <ESC>:w<CR>
vmap <leader>s <ESC>:w<CR>v

map <leader>p :set paste!<CR>

imap <leader>i #include <><LEFT>

noremap <S-tab> :bp<CR>
noremap <tab> :bn<CR>

func! CleanBlankLine()
    exec ':% s/\s\+$//'
    exec ':noh'
endfunc
map <leader>c :call CleanBlankLine()<CR>

func! CppHeaderLib()
    let vfile = expand("$HOME/.vim/_template/cppHeaderLib")
    if filereadable(vfile) " check if cpp template exists
        exec ":.-1read " vfile
        normal G
    else
        echo vfile " not found"
    endif
endfunc
func! CppHeaderMain()
    let vfile = expand("$HOME/.vim/_template/cppHeaderMain")
    if filereadable(vfile) " check if cpp template exists
        exec ":.-1read " vfile
        normal G
    else
        echo vfile " not found"
    endif
endfunc
nnoremap <leader>h1 :call CppHeaderLib()<CR>
nnoremap <leader>h2 :call CppHeaderMain()<CR>
nnoremap <leader>hh :call CppHeaderLib()<CR>:call CppHeaderMain()<CR>

function! NumberToggle()
  if(&relativenumber)
    set norelativenumber nonumber
  elseif(&number)
    set relativenumber
  else
    set number
  endif
  set number?
endfunc
"nnoremap <F2> :call NumberToggle()<CR>
map <F2> :call NumberToggle()<CR>

" ======================================================================
" https://github.com/junegunn/vim-plug
" :PlugInstall to install
" :PlugUpgrade to upgrade
if empty(glob('~/Elan_vim/autoload/plug.vim'))
  silent !curl -fLo ~/Elan_vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/Elan_vim/plugged')
Plug 'tpope/vim-sensible'
"Plug 'ludovicchabant/vim-gutentags' "自动更新tags文件
"Plug 'w0rp/ale' "编辑文字的同时就帮你把潜在错误标注出来
"Plug 'mhinz/vim-signify' "show differences with git, svn ...
Plug 'ycm-core/YouCompleteMe'
"Plug 'Yggdroot/LeaderF'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'majutsushi/tagbar' " a class outline viewer for Vim
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/MultipleSearch'
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'kien/rainbow_parentheses.vim' " 不同颜色区分括号匹配
Plug 'scrooloose/nerdtree' " 文件树
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
call plug#end()

" ======================================================================
" ctags
set tags=./.tags;,.tags
let g:ctags_path='.tags;,tags'
let g:ctags_statusline=1

" ======================================================================
" ludovicchabant/vim-gutentags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = 'tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"======================================================================
" w0rp/ale
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"======================================================================
" Valloric/YouCompleteMe
"let g:ycm_python_binary_path = '/usr/bin/python3'
" C family Completion Path
let g:ycm_global_ycm_extra_conf='~/Elan_vim/.ycm_extra_conf.py'
" 跳转快捷键
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 停止提示是否载入本地ycm_extra_conf文件
let g:ycm_confirm_extra_conf = 0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files = 1
" 从第3个键入字符开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion = 3
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字不会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 弹出列表时选择第1项的快捷键(默认为<TAB>和<Down>)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" 弹出列表时选择前1项的快捷键(默认为<S-TAB>和<UP>)
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" 主动补全, 默认为<C-Space>
let g:ycm_key_invoke_completion = '<c-j>'
imap <leader>j <c-j>
" 停止显示补全列表(防止列表影响视野), 可以按<C-Space>重新弹出
let g:ycm_key_list_stop_completion = ['<c-k>']
imap <leader>k <c-k>
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
set completeopt=menu,menuone

"noremap <c-z> <NOP>

"let g:ycm_semantic_triggers =  {
"           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{3}'],
"           \ 'cs,lua,javascript': ['re!\w{3}'],
"           \ }

"
" Yggdroot/LeaderF
"let g:Lf_ShortcutF = '<c-p>'
"let g:Lf_ShortcutB = '<m-n>'
"noremap <leader>f :LeaderfFile<CR>
"noremap <c-n> :LeaderfMru<cr>
"noremap <c-j> :LeaderfFunction!<cr>
"noremap <c-k> :LeaderfBuffer<cr>
"noremap <c-l> :LeaderfTag<cr>
"let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
"let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
"let g:Lf_WorkingDirectoryMode = 'Ac'
"let g:Lf_WindowHeight = 0.30
"let g:Lf_CacheDirectory = expand('~/Elan_vim/cache')
"let g:Lf_ShowRelativePath = 0
"let g:Lf_HideHelp = 1
"let g:Lf_StlColorscheme = 'powerline'
"let g:Lf_PreviewResult = {'Function':0}

" junegunn/fzf.vim
noremap <leader>f :GFiles<cr>
noremap <leader>b :Buffers<cr>
noremap <leader>a :Ag<cr>
noremap <leader>t :Tags<cr>

"let g:Lf_NormalMap = {
	"\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	"\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
    "\ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
    "\ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
    "\ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
    "\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
"    \ }

nmap <F6> :TagbarToggle<CR>

set statusline =
"set statusline +=%n.
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" Name of the current function (needs taglist.vim)
"set statusline +=\ [Fun(%{Tlist_Get_Tagname_By_Line()})]
" Name of the current function (needs tagbar.vim)
set statusline +=\ %{tagbar#currenttag('%s','')}
" Name of the current branch (needs fugitive.vim)
"set statusline +=\ %{fugitive#statusline()}
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=%#CursorColumn#
" Total number of lines in the file
"set statusline +=%=%-10L
" Line, column and percentage
"set statusline +=%=%-14.(%l,%c%V%)\ %P
" utf-8
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" [unix]
" set statusline+=\[%{&fileformat}\]
" Date of the last time the file was saved
set statusline +=\ %{strftime(\"[%d/%m/%y\ %T]\",getftime(expand(\"%:p\")))}
" Percentage through file
set statusline+=\ %l:%c
set statusline+=\ (L:%L)
set statusline+=\ %p%%
set statusline+=\ 

if $TMUX != ''
	set ttimeoutlen=20
elseif &ttimeoutlen > 60 || &ttimeoutlen <= 0
	set ttimeoutlen=60
endif

" c++ mappings
au FileType c,cpp nnoremap cout istd::endl(std::cout << );<left><left>
au FileType c,cpp inoremap <leader>cout std::endl(std::cout << );<left><left>

" Golang mappings
" https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)

map <F3> :GitGutterToggle<CR>

map <F4> :NERDTreeMirror<CR>
map <F4> :NERDTreeToggle<CR>

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -std=c++11 -lpthread -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear"
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc

" for python
let python_highlight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99

" rainbow_parentheses
let g:rbpt_colorpairs = [
                        \ ['brown',       'RoyalBlue3'],
                        \ ['Darkblue',    'SeaGreen3'],
                        \ ['darkgray',    'DarkOrchid3'],
                        \ ['darkgreen',   'firebrick3'],
                        \ ['darkcyan',    'RoyalBlue3'],
                        \ ['darkred',     'SeaGreen3'],
                        \ ['darkmagenta', 'DarkOrchid3'],
                        \ ['brown',       'firebrick3'],
                        \ ['gray',        'RoyalBlue3'],
                        \ ['darkmagenta', 'DarkOrchid3'],
                        \ ['Darkblue',    'firebrick3'],
                        \ ['darkgreen',   'RoyalBlue3'],
                        \ ['darkcyan',    'SeaGreen3'],
                        \ ['darkred',     'DarkOrchid3'],
                        \ ['red',         'firebrick3'],
                        \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" file header
func SetTitle()
if &filetype == 'sh'
    call setline(1, "/#!/bin/bash")
    call append(line("."), "")
    normal G
elseif &filetype == 'python'
    call setline(1, "#!/usr/bin/env python")
    call setline(2, "# -*- coding: utf-8 -*-")
    call append(line(".")+1, "")
    normal G
endif

"if expand("%:e") == 'cpp'
"    call setline(1, "#include <cstdlib>  /* exit system malloc atoi rand */")
"    call setline(2, "#include <iostream> /* std::cout std::endl */")
"    call setline(3, "#include <cstdio>   /* fopen fgets printf */")
"    call setline(4, "#include <unistd.h> /* read sleep NULL */")
"endif

endfunc
autocmd BufNewFile *.cpp,*.php,*.pl,*.py,*.[ch],*.py,*.sh,*.java exec ":call SetTitle()"

" ===================================================================
"au FileType c,cpp nnoremap cout istd::endl(std::cout << );<left><left>
au FileType c,cpp inoremap <leader>logd DEBUG::DebugMgr::Instance()->LogD("",);<left><left><left><left>
