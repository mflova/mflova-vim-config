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
"  Plugin 'scrooloose/nerdtree-project-plugin' " NerdTree stuff
  Plugin 'PhilRunninger/nerdtree-visual-selection' " NerdTree stuff
  Plugin 'octol/vim-cpp-enhanced-highlight' " Improves colours while coding
  Plugin 'ctrlpvim/ctrlp.vim' " Search for files by its name
  Plugin 'itchyny/lightline.vim' " Coloourfil info at the bottom of file edited
  Plugin 'simeji/winresizer' " Resize and move window splits
  Plugin 'vim-scripts/ZoomWin' " Zoom a window pane
  Plugin 'LucHermitte/lh-vim-lib' " ??
  Plugin 'LucHermitte/alternate-lite' " ??
  Plugin 'kkoomen/vim-doge' " Document files and jump between TODOs
  Plugin 'yegappan/taglist' " DIsplay taglist of the current file (classes, variables...)
  Plugin 'google/vim-searchindex' " Display more info when searching a word/pattern
  Plugin 'xolox/vim-misc' " Needed for vim-session
  Plugin 'xolox/vim-session' " Save VIM sessions
  Plugin 'ericcurtin/CurtineIncSw.vim' " Toggle between source and header files
  Plugin 'mflova/ag.vim' " Search file by string
  Plugin 'RRethy/vim-illuminate' " Illuminates al words selected by the cursor
  Plugin 'gcmt/wildfire.vim' " Press enter to select everything inside parenthesis
  Plugin 'miyakogi/conoline.vim' " Highlights the line of the cursor
  Plugin 'ycm-core/YouCompleteMe' " YCM Plugin to autocomplete and syntaxis check
  Plugin 'nvie/vim-flake8' " Flake 8 Plugin
  Plugin 'mflova/vim-easycomment' " Plugin to comment lines
  Plugin 'hauleth/sad.vim' " Plugin to easily replace words
  Plugin 'hienvd/vim-stackoverflow' " Search in Stack Overflow
  Plugin 'airblade/vim-gitgutter' " Performs git diffs
  Plugin 'andymass/vim-matchup' " Matching brackets and improved use of %
  Plugin 'pixelneo/vim-python-docstring' " Easy docstirng
  Plugin 'mflova/vim-printer' " Print debugging variables easily
  Plugin 'szw/vim-g' " Google searches
  Plugin 'puremourning/vimspector' " Debugger
call vundle#end()

" Set up docstrin
let g:python_style = 'rest'
" dcs (from docstring) will generate documentation
cmap dcs Docstring

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
nnoremap <C-Down> :tabprevious<CR>
nnoremap <C-Up> :tabnext<CR>

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
nnoremap <silent> <C-w> :tabclose<CR> 
nnoremap <silent> <S-w> :q<CR>

" Toggle and untoggle NERDTree and TagList
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TlistToggle<CR>

" Creates a new tab
nmap <C-t> :tabnew<CR>

" Alternate between source and header file
map <C-k> :call CurtineIncSw()<CR>

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

"Do not ask about saving session evey time the program is closed
let g:session_autosave = 'no'

" Move between tabs in same window
" Left
nnoremap <S-Left> <C-W>h
" Bottom
nnoremap <S-Down> <C-W>j
" Top
nnoremap <S-Up> <C-W>k
" Right
nnoremap <S-Right> <C-W>l

" Temporary makes a window full screen (uses plugin)
map <S-x> <c-w>o

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
autocmd FileType python map <buffer> <F4> :call flake8#Flake8()<CR>
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

