set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'flazz/vim-colorschemes'
  Plugin 'preservim/nerdtree'
  Plugin 'xuyuanp/nerdtree-git-plugin'
  Plugin 'scrooloose/nerdtree-project-plugin'
  Plugin 'PhilRunninger/nerdtree-visual-selection'
  Plugin 'octol/vim-cpp-enhanced-highlight'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'itchyny/lightline.vim'  
  Plugin 'simeji/winresizer'
  Plugin 'vim-scripts/ZoomWin'
  Plugin 'LucHermitte/lh-vim-lib'
  Plugin 'LucHermitte/alternate-lite'
  Plugin 'kkoomen/vim-doge'
  Plugin 'yegappan/taglist'
  Plugin 'google/vim-searchindex'
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-session'
  Plugin 'ericcurtin/CurtineIncSw.vim'
  Plugin 'mflova/ag.vim'
  Plugin 'RRethy/vim-illuminate'
  Plugin 'gcmt/wildfire.vim'
  Plugin 'miyakogi/conoline.vim'
  Plugin 'ycm-core/YouCompleteMe'
  Plugin 'nvie/vim-flake8'
  Plugin 'mflova/vim-easycomment' 
call vundle#end()

" Set CtrlP to ignore specific extensions
set wildignore+=*/.git/*,*/.dir/*,*/.make/*,*/.o/*,*/.cmake,*/.cpp.o,*/.pyc/* 

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

set mouse-=a
set number
set autoindent
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
" When disabled, CtrlP won't visualize cache
" Which means that if a new file is created
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
set colorcolumn=90 textwidth=90

" Jump between TODOs
" TODO

" Enable/Disable autocomplete (YCM Based)
let g:loaded_youcompleteme = 0

""" Flake8 
" Autodetects python files to run flake8
" Runs Flake8 and maps it in F4
if !empty(glob("~/.vim/bundle/vim-flake8/ftplugin/python_flake8.vim"))
    source ~/.vim/bundle/vim-flake8/ftplugin/python_flake8.vim
endif
" Display the markers in the file
let g:flake8_show_in_file=1  " show
autocmd FileType python map <buffer> <F4> :call flake8#Flake8()<CR>
autocmd BufNewFile,BufRead *.py set ft=python
" This searches for the .flake8 to be loaded.
" It will start in the current path and it will go back in folders n_folders times
let flake8_string = ".flake8"
let n_folders = 7
let counter = 0
while counter <= n_folders
  if !empty(glob(flake8_string))
    let g:flake8_cmd=flake8_string
  endif
  let flake8_string = "../" . flake8_string
  let counter += 1
endwhile


vmap <silent> <C-x> :call ToggleCommentVisual()<CR>
nmap <silent> <C-x> :call ToggleCommentLine()<CR>

