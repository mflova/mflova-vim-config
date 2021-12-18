set nocompatible              " be iMproved, required
filetype off                  " required

" Maps the leader key
let mapleader = " "
let maplocalleader=" "

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

filetype plugin on  " Added by me. If bundle does not work properly, delete it temporary. Used for Doge documentation generator

call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'flazz/vim-colorschemes' " Install multiple colorschemes
  Plugin 'preservim/nerdtree' " NerdTree stuff
  Plugin 'tomasr/molokai' " Theme
  Plugin 'morhetz/gruvbox' " Theme
  Plugin 'joshdick/onedark.vim' " THeme
  Plugin 'xuyuanp/nerdtree-git-plugin' " NerdTree stuff
  Plugin 'PhilRunninger/nerdtree-visual-selection' " NerdTree stuff
  Plugin 'octol/vim-cpp-enhanced-highlight' " Improves colours while coding
  Plugin 'vim-airline/vim-airline' " Status line at the bottom
  Plugin 'vim-airline/vim-airline-themes' " Themes for vim airline
  Plugin 'simeji/winresizer' " Resize and move window splits
  Plugin 'szw/vim-maximizer' " Zoom a window pane
  Plugin 'LucHermitte/lh-vim-lib' " ??
  Plugin 'LucHermitte/alternate-lite' " ??
  Plugin 'kkoomen/vim-doge', { 'do': { ->doge#install() } }  " Document files and jump between TODOs
  Plugin 'yegappan/taglist' " DIsplay taglist of the current file (classes, variables...)
  Plugin 'google/vim-searchindex' " Display more info when searching a word/pattern
  Plugin 'xolox/vim-misc' " Needed for vim-session
  Plugin 'xolox/vim-session' " Save VIM sessions
  Plugin 'ericcurtin/CurtineIncSw.vim' " Toggle between source and header files
  Plugin 'ggreer/the_silver_searcher'
  Plugin 'RRethy/vim-illuminate' " Illuminates al words selected by the cursor
  Plugin 'gcmt/wildfire.vim' " Press enter to select everything inside parenthesis
  Plugin 'miyakogi/conoline.vim' " Highlights the line of the cursor
  Plugin 'ycm-core/YouCompleteMe' " YCM Plugin to autocomplete and syntaxis check
  Plugin 'nvie/vim-flake8' " Flake 8 Plugin
  Plugin 'mflova/vim-easycomment' " Plugin to comment lines
  Plugin 'hauleth/sad.vim' " Plugin to easily replace words
  Plugin 'hienvd/vim-stackoverflow' " Search in Stack Overflow
  Plugin 'airblade/vim-gitgutter' " Only used to show the +,- and ~ of changed lines from last commit
  Plugin 'andymass/vim-matchup' " Matching brackets and improved use of %
  Plugin 'mflova/vim-python-docstring' " Modified for the templates
  Plugin 'mflova/vim-printer' " Print debugging variables easily
  Plugin 'szw/vim-g' " Google searches
  " Plugin 'mflova/vimspector' " Debugger. Needs Vim 8.2. To be set up in the future.
  Plugin 'mflova/vim-easymotion' " Improved motion for vim
  Plugin 'tpope/vim-fugitive' " GIT commands in VIM
  Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder stuff for vim
  Plugin 'junegunn/fzf.vim' " Fuzzy finder stuff for vim
  Plugin 'fisadev/vim-isort' " Isort plugin to order imporst in Python
  Plugin 'rhysd/vim-grammarous' " Grammar checks
  Plugin 'dense-analysis/ale' " Complete syntax plugin: checker and fixes based on differed plugins
  Plugin 'mflova/vim-getting-things-down' " ToDo list manager
  Plugin 'AndrewRadev/splitjoin.vim' " Split function arguments into multiple lines
  Plugin 'vim-test/vim-test' " Execute unit tests in VIM
call vundle#end()

" It will update the time in which gitguutter is refreshed
set updatetime=200 
" Use vim as mergetool with
" git config --global mergetool.fugitive.cmd 'vim -f -c "Gvdiffsplit!" "$MERGED"'
" git config --global merge.tool fugitive
"
" Open files unfolded by default
au BufRead * normal zR

" Set up docstrings
let g:python_style = 'rest' " Used for documenting classes, as Doge only handles functions
let g:doge_remove_nones = 1 " Only works for sphinx-python
" Python docstring generator. It uses a different command for functions and
" classes, as the DoGe plugin does not work with classes.
nnoremap <silent><C-d> :DogeGenerate<CR>
autocmd FileType python nnoremap <silent><C-d> :call PythonGenerateDocstring()<CR>
function! PythonGenerateDocstring()
    let l:line = getline('.')
    let l:words = split(l:line, ' ')
    if l:words[0] == 'def'
        DogeGenerate sphinx
    endif
    if l:words[0] == 'class'
        Docstring
    endif
endfunction

" Shorts the import according to PEP8
cmap isort Isort

" vterm for vertical term
" term for horintal term
nnoremap <silent><leader>tv :vert term<CR>
nnoremap <silent><leader>tx :term<CR>

cmap <C-l> :set paste<CR>yaw<Esc>``:set nopaste<CR>

" Set CtrlP to ignore specific extensions
let g:ctrlp_custom_ignore = '\.pyc$\|\.cpp.o$\|\.dat$\|\.git$\|\.dir$\|__init__.py$'

" When using the / tool, it will not be sensitive case unless you write some case letters.
set ignorecase
set smartcase

" Set colortheme
syntax on
colorscheme molokai " molokai or onedark
"set bg=dark " For gruvbox only
"let g:gruvbox_contrast_dark='hard' " For gruvbox

" Highlights the current line of the cursor
let g:conoline_auto_enable = 1

" Change between tabs
nnoremap <silent><C-Down> :tabprevious<CR>
nnoremap <silent><C-Up> :tabnext<CR>

"Auto reload files
set autoread 
au CursorHold * checktime 

" Set tab to be 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Use mouse to copy-paste
set mouse-=a

" Numbers in line VIM
set number

" Autoindent
set autoindent

" Maps the delete key in the normal way
set backspace=indent,eol,start

" Highlights the word while being written in /
set incsearch

" Close tabs with Ctrl + w 
cmap tclose tabclose 

" Toggle and untoggle NERDTree and TagList
nmap <silent><F2> :NERDTreeToggle<CR>

" Creates a new tab
nmap <silent><C-t> :tabnew<CR>

" Alternate between source and header file
map <silent><C-k> :call CurtineIncSw()<CR>

" Opens TagList at right
let Tlist_Use_Right_Window   = 1

" Split files by default at right and down
set splitbelow
set splitright
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='x'

" Set directory of Ctrl + P
let g:ctrlp_cmd='CtrlP :pwd'
" When disabled, CtrlP won't visualize cache Which means that if a new file is created
" it will appear instantly
let g:ctrlp_use_caching=0

" Insert space and go to insert mode
nnoremap space i<space>

" Easier commands definition
cmap ntsave NERDTreeProjectSave
cmap ntload NERDTreeProjectLoad
cmap ntrm NERDTreeProjectRm 
cmap vsave SaveSession
cmap vload OpenSession

" Fzf remaps
nnoremap <silent><C-p> :Files<Cr>
nnoremap <silent><C-g> :Ag<Cr>
nnoremap <silent><C-b> :BLines<CR>
nnoremap <silent><C-f> :Lines<CR>
" Set how the window appears in the FZF command
let g:fzf_layout = { 'down': '~35%' }
" Define a function that will allow fzf to build a quicfix list from selected
" files
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }



"Do not ask about saving session evey time the program is closed
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" Move between tabs in same window
" Left
nnoremap <S-Left> <C-W>h
tnoremap <S-Left> <C-W>h
" Bottom
nnoremap <S-Down> <C-W>j
tnoremap <S-Down> <C-W>j
" Top
nnoremap <S-Up> <C-W>k
tnoremap <S-Up> <C-W>k
" Right
nnoremap <S-Right> <C-W>l
tnoremap <S-Right> <C-W>l

" Temporary makes a window full screen (uses plugin)
nnoremap <silent><S-x> :MaximizerToggle<CR>

" Resize windows (uses a plugin)"
let g:winresizer_keycode_up = "\<UP>"
let g:winresizer_keycode_down = "\<DOWN>"
let g:winresizer_keycode_left = "\<LEFT>"
let g:winresizer_keycode_right = "\<RIGHT>"
let g:winresizer_horiz_resize = 2
let g:winresizer_vert_resize = 2

" NERDTree sets the current working directory. Useful for Vgrep command
let g:NERDTreeChDirMode = 2

" This line will make the window close after a file is chosen in grep style commands
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" Limit maximumg of line: gqap in normal mode
highlight ColorColumn ctermbg=233
" set colorcolumn=90 textwidth=90

" Enable/Disable autocomplete (YCM Based)
let g:loaded_youcompleteme = 1 
let g:ycm_auto_trigger = 1

" vim airline (status bar) also available with one window split 
set laststatus=2

" Commenting line(s) with these two lines
vmap <silent> <Leader>c :call ToggleCommentVisual()<CR>
nmap <silent> <Leader>c :call ToggleCommentLine()<CR>

" Replace mode
nmap S <Plug>(sad-change-forward)
xmap S <Plug>(sad-change-forward)

" Jump between TODOs
" TODO

" Easy motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" One char
map <Leader>. <Plug>(easymotion-repeat)
map <Leader>f <Plug>(easymotion-bd-f) 
map <Leader>F <Plug>(easymotion-overwin-f)
map <Leader>e <Plug>(easymotion-bd-e)
map <Leader>j <Plug>(easymotion-overwin-line)
map <Leader>k <Plug>(easymotion-overwin-line)
map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>W <Plug>(easymotion-overwin-w)

" Toggle fold/unfolded code in the file. Not only valid for diff
" Mapped below
let g:is_folded=0 " This is how the file is opened by default
function! ToggleFoldDiff()
    if g:is_folded == 1
        call feedkeys("\zR")
        let g:is_folded=0
    else
        call feedkeys("\zM")
        let g:is_folded=1
    endif
endfunction
" Introduces Git diff from fugitive
command! -bar Gclogfunc execute '.Gclog -L :' . expand('<cword>') . ':%'
" Zr means that by default, the diff will be fully unfolded
map <silent><Leader>gdf :Gvdiffsplit<CR>zR 
map <silent><Leader>gdd :Gvdiffsplit develop<CR>zR
map <silent><Leader>gdm :Gvdiffsplit master<CR>zR
map <silent><Leader>gt :call ToggleFoldDiff()<CR>
map <silent><Leader>gh :%Gclog<CR>
map <silent><Leader>gH :Gclogfunc<CR>

" Delete entire word in insert mode
imap <C-d> <C-[>diwi
" Paste something yanked in insert mode
imap <C-v> <C-[>pi

" Quickfix and location windows maps:
" v and x for vertical/horizontal split
autocmd! FileType qf nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd! FileType qf nnoremap <buffer> x <C-w><Enter>

" ALE CONFIG (Used for its linters)
" Enabled at startup by default. Only read at startup
let g:ale_enabled = 1
" Constants defined for the vim airline status bar when the ale linters are
" ON/OFF
let g:mflova_linters_on = '' " Hides the message when linters are ON
let g:mflova_linters_off = 'LINTERS OFF'
" Files where ALE is disabled
" Init the status bar with the correct message

let g:is_ale_running = g:ale_enabled
if g:ale_enabled
    let g:ale_status_bar = g:mflova_linters_on
else
    let g:ale_status_bar = g:mflova_linters_off
endif
" ALE toggle: It uses mypy, flake8...
nnoremap <silent><Leader>at :call ALEToggleWrapper()<CR>
" Function that not only toggles ALE but also its message to be printed in vim
" airline
function! ALEToggleWrapper()
    if g:is_ale_running
        let g:ale_status_bar = g:mflova_linters_off
        let g:is_ale_running = 0
    else
        let g:ale_status_bar = g:mflova_linters_on
        let g:is_ale_running = 1
    endif
    ALEToggle
endfunction

" Save the status when entering in a special file
let g:mflova_ale_prev_status = g:is_ale_running
function! ALETemporaryDisable()
    let g:mflova_ale_prev_status = g:is_ale_running
    let g:ale_status_bar = g:mflova_linters_off
    ALEDisable
endfunction

" Restore the saved status
function! ALERestoreStatus()
    if g:mflova_ale_prev_status == 1
        let g:ale_status_bar = g:mflova_linters_on
        ALEEnable
    endif
endfunction

" Files where ALE is disabled
autocmd BufEnter TODO.md exe "call ALETemporaryDisable()"
autocmd BufEnter NOTES.md exe "call ALETemporaryDisable()"
autocmd BufLeave TODO.md exe "call ALERestoreStatus()"
autocmd BufLeave NOTES.md exe "call ALERestoreStatus()"

nnoremap <silent><Leader>af :ALEFix<CR>
let g:ale_fixers = ['autopep8', 'yapf']
" Dictionary that maps languages with linters. Only Python has been added so far
" Flake8 Plugins Installed:
"    - darglint -> Errors at docstrings
"    - pytest style -> Extra functions for pytest for better code
"    - flake8-simplify -> Simplify code
"    - flake8-bugbear -> Detecting bugs
"    - dlint -> Security stuff. It might be annoying
"    - comprehensions -> Comprehension stuff (list, set, dicts...)
"    - flake8-commas -> Check for missing trailing commas
"    - flake8-rst-docstrings -> rst docstring checker
"    - flake8-markdown -> Checks for python code blocks in .md
"    - flake8-builtins -> Checks builtins collision names
"    - flake8-broken-line -> Improves broken lines style with backslash
"    - flake8-class-attributes-order -> Checks order the attributes of a class
"                   \ 'python': ['pylint', 'mypy', 'pydocstyle', 'vulture', 'flake8'],
let g:ale_linters = {
                   \ 'python': ['mypy'],
                   \ 'rst': ['proselint', 'rstcheck'],
                   \ 'yaml': ['yamllint'],
                   \ 'cmake': ['cmakelint'],
                   \ 'cpp': ['clangtidy'],
                   \ 'markdown': ['mdl']}
" Ignoring specific warnings/errors. Strict one forces you to write always the optional typing
let g:ale_python_mypy_options = '--strict'
" Those variables with less than 3 characteres and not in this list will be considered as warning
let g:ale_python_pylint_options = '--good-names="q1, q2, q3, q4, q5, q, i, j, k, df, dt" --disable="W0102, W0212, R0913, R0903, R0902, R0914, W0621"'
" Some plugins were integrated into flake8. Install with pip the following
" ones:
let g:ale_python_flake8_options = ' --docstring-style sphinx --max-line-length=90 --indenxt-size=4' 
let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length:{max: 90}}}"' 
let g:ale_cmake_cmakelint_options = '--linelength=120' 
let g:ale_cpp_cpplint_options = '--linelength=90 --filter="-legal/copyright, -whitespace/braces, -whitespace/newline"'  " The brace ones are ignore due to personal change in style
let g:ale_cpp_cppcheck_options = '--std="c++17"' 
let g:ale_cpp_clangtidy_options = '--format-style="google"' 
let g:ale_markdown_mdl_options = '--rules MD001,MD002,MD003,MD004,MD005,MD006,MD007,MD009,MD010,MD011,MD012,MD013,MD014,MD018,MD019,MD020,MD021,MD022,MD023,MD024,MD025,MD026,MD027,MD028,MD030,MD031,MD032,MD033,MD034,MD035,MD036,MD037,MD038,MD039,MD040,MD041,MD046,MD047' " Just wanted to ignore one rule...
" Update the messages printed in the status bar to show the liner, the message and the severity
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" To do list manager
" Quick-switch between current file and `TODO.md` of project root
nnoremap <LocalLeader><LocalLeader> :call getting_things_down#show_todo()<CR>

" TagList
nmap <F4> :TlistToggle<CR>

" Testing inside vim
cmap tfile TestFile
cmap tsuite TestSuite
cmap tthis TestNearest

" Colortheme for the statusline
let g:airline_theme='onedark'
" Removes the encoding in the status bar
let g:airline#extensions#default#layout = [['a','b', 'c'], ['x', 'z', 'warning', 'error']] 
" A
" b will be the first oen truncated (branch name)
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 100,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

" Update the var by reading this variable
let g:airline_section_warning = '%{ale_status_bar}'


" Stubs stuff: Generates the ones in the cursor with the Genstubs command
command! -nargs=1 RunCMDSilent execute ':silent !'.<q-args> | execute ':redraw!'
function! Genstubs()
    let l:line = getline('.')
    let l:words = split(l:line, '[ .]')
    let g:mflova_stubgen_args = 'stubgen -o $MYPYPATH '
    if l:words[0] == "import"
"    Case1: Import XXX (as XXX) -m XXX 
        if l:words[2] == "as"
            let g:mflova_stubgen_args = g:mflova_stubgen_args . '-m ' . l:words[1]
"    Case2: Import XXX.XXX.XXX -p XXX (first)
        else
            let g:mflova_stubgen_args = g:mflova_stubgen_args . '-p ' . l:words[1]
        endif
    endif
"    Case3: From XXX.XXX.XXX import XXX -p XXX (the first one)
    if l:words[0] == "from"
        let g:mflova_stubgen_args = g:mflova_stubgen_args . '-p ' . l:words[1]
    endif
    execute ':RunCMDSilent ' . g:mflova_stubgen_args
endfunction
map <silent><Leader>as :call Genstubs()<CR>
