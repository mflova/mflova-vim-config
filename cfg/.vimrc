set nocompatible              " be iMproved, required
filetype off                  " required

" Maps the leader key
let mapleader = " "

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'flazz/vim-colorschemes' " Install multiple colorschemes
  Plugin 'preservim/nerdtree' " NerdTree stuff
  Plugin 'xuyuanp/nerdtree-git-plugin' " NerdTree stuff
  Plugin 'PhilRunninger/nerdtree-visual-selection' " NerdTree stuff
  Plugin 'octol/vim-cpp-enhanced-highlight' " Improves colours while coding
  Plugin 'itchyny/lightline.vim' " Coloourfil info at the bottom of file edited
  Plugin 'simeji/winresizer' " Resize and move window splits
  Plugin 'szw/vim-maximizer' " Zoom a window pane
  Plugin 'LucHermitte/lh-vim-lib' " ??
  Plugin 'LucHermitte/alternate-lite' " ??
  Plugin 'kkoomen/vim-doge' " Document files and jump between TODOs
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
  Plugin 'pixelneo/vim-python-docstring' " Easy docstirng
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
call vundle#end()

" Set up docstrin
let g:python_style = 'rest'
" dcs (from docstring) will generate documentation
cmap dcs Docstring

" Shorts the import according to PEP8
cmap isort Isort

" vterm for vertical term
" term for horintal term
nnoremap <silent><leader>tv :vert term<CR>
nnoremap <silent><leader>tx :term<CR>

cmap <C-l> :set paste<CR>yaw<Esc>``:set nopaste<CR>

" Set CtrlP to ignore specific extensions
let g:ctrlp_custom_ignore = '\.pyc$\|\.cpp.o$\|\.dat$\|\.git$\|\.dir$\|__init__.py$'


" Updates vim each 100ms instead of 4000ms (default value)
set updatetime=100

" When using the / tool, it will not be sensitive case unless you write some case letters.
set ignorecase
set smartcase

" Set colortheme
syntax on
colorscheme molokai

" Highlights the current line of the cursor
let g:conoline_auto_enable = 1

" Change between tabs
nnoremap <silent><C-Down> :tabprevious<CR>
nnoremap <silent><C-Up> :tabnext<CR>

"Auto reload files
set autoread 
au CursorHold * checktime 

" [buffer number] followed by filename:
set statusline=[%n]\ %t
" for Syntastic messages:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" show line#:column# on the right hand side
set statusline+=%=%l:%c

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
nmap <Leader>t :TlistToggle<CR>

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
cmap vgrep Ag

" Fzf remaps
nnoremap <silent><C-p> :Files<Cr>
nnoremap <silent><C-g> :Ag<Cr>
nnoremap <silent><C-b> :BLines<CR>
nnoremap <silent><C-f> :Lines<CR>

" Set how the window appears in the FZF command
let g:fzf_layout = { 'down': '~30%' }
" Avoid opening files if the are already opened
let g:fzf_action = {
  \ 'ctrl-t': 'tab drop',
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

""" Flake8 
" Autodetects python files to run flake8
" Runs Flake8 and maps it in F4
if !empty(glob("~/.vim/bundle/vim-flake8/ftplugin/python_flake8.vim"))
    source ~/.vim/bundle/vim-flake8/ftplugin/python_flake8.vim
endif
" Display the markers in the file
let g:flake8_show_in_file=1  " show
" Mapping the key to F4
autocmd FileType python map <buffer> <silent><F4> :call flake8#Flake8()<CR>
" Only works with Python
autocmd BufNewFile,BufRead *.py set ft=python

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
let g:is_folded=1
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
map <silent><Leader>gdf :Gvdiffsplit<CR>
map <silent><Leader>gdd :Gvdiffsplit develop<CR>
map <silent><Leader>gdm :Gvdiffsplit master<CR>
map <silent><Leader>gt :call ToggleFoldDiff()<CR>
map <silent><Leader>gh :%Gclog<CR>
map <silent><Leader>gH :Gclogfunc<CR>

" Delete entire word in insert mode
imap <C-d> <C-[>diwi
" Paste something yanked in insert mode
imap <C-v> <C-[>pi

" Ctags (jump to function definitions)
" Build tags file automatically
" Auto generate tags file on file write of *.c and *.h files
autocmd BufWritePost *.c,*.h,*.py silent! !ctags . &
nnoremap <Leader>td <c-w>v<c-]>

" Quickfix and location windows maps:
" v and x for vertical/horizontal split
autocmd! FileType qf nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd! FileType qf nnoremap <buffer> x <C-w><Enter>

" ALE toggle: It uses mypy, flake8...
nnoremap <silent><Leader>at :ALEToggle<CR>
nnoremap <silent><Leader>af :ALEFix<CR>

" ALE CONFIG
let g:ale_fixers = ['autopep8', 'yapf']
" Dictionary that maps languages with linters. Only Python as been added so far
let g:ale_linters = {'python': ['pydocstyle', 'flake8', 'pylint', 'mypy', 'pycodestyle', 'pydocstyle']}
" Ignoring specific warnings/errors
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_pylint_options = '--disable="W0102, W0212, R0913, R0903, R0902, R0914"'
let g:ale_python_pycodestyle_options = '--ignore=E501' " Handled by Flake8
let g:ale_python_flake8_options = '-m flake8 --max-line-length=90' " If removed, .flake8 will be read isntead with the proper configuration
