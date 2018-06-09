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

set nobackup
set noswapfile

set background=dark
set t_Co=256
" colorscheme molokai
"set scrolloff=2

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

map <leader>h <HOME>
imap <leader>h <HOME>
vmap <leader>h <HOME>
map <leader>l <END>
imap <leader>l <END>
vmap <leader>l <END>

map <leader>q :qa<CR>
imap <leader>q <ESC>:qa<CR>
vmap <leader>q <ESC>:qa<CR>

map <leader>Q :qa!<CR>
imap <leader>Q <ESC>:qa!<CR>
vmap <leader>Q <ESC>:qa!<CR>

map <leader>S :wqa!<CR>
imap <leader>S <ESC>:wqa!<CR>
vmap <leader>S <ESC>:wqa!<CR>

map <leader>s :w<CR>
imap <leader>s <ESC>:w<CR>a
vmap <leader>s <ESC>:w<CR>v

map <leader>p :set paste!<CR>

noremap <S-tab> :bp<CR>
noremap <tab> :bn<CR>

func! CleanBlankLine()
    exec ':% s/\s\+$//'
    exec ':noh'
endfunc
map <leader>c :call CleanBlankLine()<CR>

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
nnoremap <F2> :call NumberToggle()<CR>

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
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/LeaderF'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()

" ======================================================================
" ctags
set tags=./tags;,tags

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
let g:ycm_global_ycm_extra_conf = '~/Elan_vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
"ctags
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

noremap <c-z> <NOP>

"let g:ycm_semantic_triggers =  {
"           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{3}'],
"           \ 'cs,lua,javascript': ['re!\w{3}'],
"           \ }

"
" Yggdroot/LeaderF
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <leader>f :LeaderfFile<CR>
noremap <c-n> :LeaderfMru<cr>
noremap <c-j> :LeaderfFunction!<cr>
noremap <c-k> :LeaderfBuffer<cr>
noremap <c-l> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/Elan_vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0}

let g:Lf_NormalMap = {
	\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }

