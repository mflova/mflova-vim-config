set nocompatible              " be iMproved, required
filetype off                  " required

" Maps the leader key
let mapleader = " "
let maplocalleader=" "
" Map ALT as M
" Example: nnoremap <M-j> j
execute "set <M-j>=\ej"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Path used to perform relative imports 
let s:vim_cfg_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

filetype plugin on  " Added by me. If bundle does not work properly, delete it temporary. Used for Doge documentation generator

" Command to run other commands from shell (write them as argument)
command! -nargs=1 RunCMDSilent execute ':silent !'.<q-args> | execute ':redraw!'

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
  Plugin 'SirVer/ultisnips' " Snippets engine
  Plugin 'mflova/vim-snippets' " Collection of snippets
  Plugin 'mflova/fzf-checkout.vim' " Manage git branches with FZF engine
  Plugin 'chrisbra/vim-diff-enhanced' " Diff visualizer enhanced
  Plugin 'mflova/vim-fuzzy-stash' " Vim fuzzy stash
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
    if len(l:line) != 0
        let l:words = split(l:line, ' ')
        if l:words[0] == 'def'
            DogeGenerate sphinx
        endif
        if l:words[0] == 'class'
            Docstring
        endif
    endif
endfunction

" Shorts the import according to PEP8
cmap isort Isort

" vterm for vertical term
" term for horintal term
nnoremap <silent><leader>tv :vert term<CR>
nnoremap <silent><leader>tx :term<CR>

cmap <C-l> :set paste<CR>yaw<Esc>``:set nopaste<CR>

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

"Auto reload files
set autoread 
au CursorHold * checktime 

" Common clipboard between vim and the ubuntu system
set clipboard=unnamed
set clipboard=unnamedplus

" Color
highlight HighlightedyankRegion cterm=reverse gui=reverse

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
nmap <silent><C-x> :call CurtineIncSw()<CR>

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


" Delete entire word in insert mode
imap <C-d> <C-[>diwi
" Paste something yanked in insert mode
imap <C-v> <C-[>pi

" Toggle/Untoggle folds
map <silent><Leader>t :call ToggleFoldDiff()<CR>
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

" Quickfix and location windows maps:
" v and x for vertical/horizontal split
"autocmd! FileType qf nnoremap <buffer> <leader>ov <C-w><Enter><C-w>L
autocmd! FileType qf nnoremap <buffer> x <C-w><Enter>
" Move between items
nmap <C-Down> :cn<CR>
nmap <C-Up> :cp<CR>
" QF default location: Very bottom
autocmd FileType qf wincmd J
" Adjust the quickfix height to the number of elemens. Maximum 10
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

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

" Snippets mapping
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips", s:vim_cfg_path .'/snippets']

" Imports
let s:ale_cfg_path = s:vim_cfg_path . '/ale.vim'
let s:git_cfg_path = s:vim_cfg_path . '/git.vim'
let s:fzf_cfg_path = s:vim_cfg_path . '/fzf.vim'

exec 'source ' . s:ale_cfg_path
exec 'source ' . s:git_cfg_path
exec 'source ' . s:fzf_cfg_path
