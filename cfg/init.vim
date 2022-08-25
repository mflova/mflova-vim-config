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

" Path used to perform relative imports 
let s:vim_cfg_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

filetype plugin on  " Added by me. If bundle does not work properly, delete it temporary. Used for Doge documentation generator

" Command to run other commands from shell (write them as argument)
command! -nargs=1 RunCMDSilent execute ':silent !'.<q-args> | execute ':redraw!'

call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'flazz/vim-colorschemes' " Install multiple colorschemes
  Plugin 'tomasr/molokai' " Theme
  Plugin 'morhetz/gruvbox' " Theme
  Plugin 'joshdick/onedark.vim' " THeme
  Plugin 'octol/vim-cpp-enhanced-highlight' " Improves colours while coding
  Plugin 'simeji/winresizer' " Resize and move window splits
  Plugin 'szw/vim-maximizer' " Zoom a window pane
  Plugin 'LucHermitte/lh-vim-lib' " ??
  Plugin 'LucHermitte/alternate-lite' " ??
  Plugin 'kkoomen/vim-doge', { 'do': { ->doge#install() } }  " Document files and jump between TODOs
  Plugin 'google/vim-searchindex' " Display more info when searching a word/pattern
  Plugin 'xolox/vim-misc' " Needed for vim-session
  Plugin 'xolox/vim-session' " Save VIM sessions
  Plugin 'ericcurtin/CurtineIncSw.vim' " Toggle between source and header files
  Plugin 'ggreer/the_silver_searcher'
"  Plugin 'gcmt/wildfire.vim' " Press enter to select everything inside parenthesis
  Plugin 'miyakogi/conoline.vim' " Highlights the line of the cursor
  Plugin 'mflova/vim-easycomment' " Plugin to comment lines
  Plugin 'hauleth/sad.vim' " Plugin to easily replace words
  Plugin 'hienvd/vim-stackoverflow' " Search in Stack Overflow
  Plugin 'airblade/vim-gitgutter' " Only used to show the +,- and ~ of changed lines from last commit
  Plugin 'andymass/vim-matchup' " Matching brackets and improved use of %
  Plugin 'mflova/vim-python-docstring' " Modified for the templates
  Plugin 'mflova/vim-printer' " Print debugging variables easily
  Plugin 'szw/vim-g' " Google searches
  Plugin 'dominikduda/vim_current_word' "Highlight the current word 
  Plugin 'tpope/vim-fugitive' " GIT commands in VIM
  Plugin 'salcode/vim-interactive-rebase-reverse' " Change commit order in rebase interactive
  Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder stuff for vim
  Plugin 'junegunn/fzf.vim' " Fuzzy finder stuff for vim
  Plugin 'tenfyzhong/fzf-marks.vim'  " Integration of fzf marks by using FZFFzm command
  Plugin 'nvim-telescope/telescope.nvim' " Another FZF finder
  Plugin 'nvim-telescope/telescope-fzf-native.nvim' " FZF native sorter for telescope
  Plugin 'fisadev/vim-isort' " Isort plugin to order imporst in Python
  Plugin 'rhysd/vim-grammarous' " Grammar checks
  Plugin 'AndrewRadev/splitjoin.vim' " Split function arguments into multiple lines
  Plugin 'mflova/fzf-checkout.vim' " Manage git branches with FZF engine
  Plugin 'chrisbra/vim-diff-enhanced' " Diff visualizer enhanced
  Plugin 'mflova/vim-fuzzy-stash' " Vim fuzzy stash
  Plugin 'mflova/vim-test' " To be used in ultest
  Plugin 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' } " To test in real time
  Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plugin 'neovim/nvim-lspconfig' " LSP configurations
  Plugin 'mflova/nvim-lint' " Linters with the built-in LSP neovim
"  Plugin 'mfussenegger/nvim-lint' " Linters with the built-in LSP neovim
  Plugin 'nvim-lua/plenary.nvim' " Developing plugins
  Plugin 'kyazdani42/nvim-web-devicons' " Cool icons
  Plugin 'williamboman/nvim-lsp-installer' " LSP Installer
  Plugin 'mflova/trouble.nvim' " Better diagnos navigation and LSP features
  Plugin 'vimwiki/vimwiki'
  Plugin 'pwntester/octo.nvim' " Git online management

  " Refactoring
"  Plugin 'python-rope/ropevim' " Refactoring for Python
"  Plugin 'ThePrimeagen/refactoring.nvim' " Refactoring API

  " File explorer and file navigation
  Plugin 'kyazdani42/nvim-tree.lua' " Lua file explorer
  Plugin 'liuchengxu/vista.vim' " Taglist compatible with LSP
  Plugin 'rbgrouleff/bclose.vim' " Ranger dependency
  Plugin 'francoiscabrol/ranger.vim' " Ranger
  Plugin 'phaazon/hop.nvim' " Move between words in the file
  Plugin 'ziontee113/syntax-tree-surfer' " Navigate using TS

  " Snippets
  Plugin 'L3MON4D3/LuaSnip' " Snippets engine
  Plugin 'mflova/friendly-snippets' " Collection of snippets

  " Misc
  " Spotify 
  Plugin 'KadoBOT/nvim-spotify', { 'do': 'make' } " Wrapper for spotify
  Plugin 'lervag/vimtex'

  " CSV Visualizer
  Plugin 'chrisbra/csv.vim'

  " Status line
  Plugin 'nvim-lualine/lualine.nvim' " Staus line
  Plugin 'SmiteshP/nvim-gps' " Component that tells you the current function

  " cmp
  Plugin 'lukas-reineke/cmp-under-comparator'  " Improve otder of cmp in python
  Plugin 'hrsh7th/cmp-nvim-lsp'
  Plugin 'hrsh7th/cmp-buffer'
  Plugin 'hrsh7th/cmp-path'
  Plugin 'hrsh7th/cmp-cmdline'
  Plugin 'hrsh7th/nvim-cmp'
  Plugin 'saadparwaiz1/cmp_luasnip'
  Plugin 'ray-x/lsp_signature.nvim' " Real-time parameters for the function
"  Plugin 'hrsh7th/cmp-nvim-lsp-signature-help'

  " Coding
  Plugin 'michaelb/sniprun', {'do': 'bash install.sh'} " Run the specified lines
  Plugin 'jiangmiao/auto-pairs' " Auto pairs for brackets and stuff like that
  Plugin 'yhat/vim-docstring' " Fold docstrings
  Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown Previwer
  Plugin 'Rykka/InstantRst' " RST previewers
  "Plugin 'Rykka/riv.vim' " RST previewers
  
  " Misc
  Plugin 'jbyuki/nabla.nvim'
  Plugin 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
  Plugin 'nathom/filetype.nvim' " Faster Startup

  " LSP
  Plugin 'brymer-meneses/grammar-guard.nvim'  " Markdown/Latex LSP based on ltex

  " Debugger
  Plugin 'mfussenegger/nvim-dap'
  Plugin 'rcarriga/nvim-dap-ui'
  Plugin 'mfussenegger/nvim-dap-python'
  Plugin 'theHamsta/nvim-dap-virtual-text'

  " UI
  Plugin 'glepnir/dashboard-nvim' " Startup
  Plugin 'Yagua/nebulous.nvim' " Theme
  Plugin 'onsails/lspkind-nvim' " Pictograms
  Plugin 'folke/lsp-colors.nvim' " Useful for themes
  Plugin 'folke/tokyonight.nvim' " Theme
  Plugin 'mhartington/oceanic-next' " Theme
  Plugin 'PHSix/nvim-hybrid' " Theme
  Plugin 'xiyaowong/nvim-transparent' " Transparent

  " Git (new plugins)
  Plugin 'rbong/vim-flog' " Commit browser, git log
  Plugin 'sindrets/diffview.nvim'  " Diff viewer with multiple files side by side
call vundle#end()

" Install VIM plugins with this in shell:
" export INSTALL_VIM_PLUGINS=1 && nvim +'' +qa && unset INSTALL_VIM_PLUGINS
if $INSTALL_VIM_PLUGINS == 1
    PluginInstall
endif

" Avoid folds by default
set nofoldenable

nmap <silent>q :q<CR> 

" Edit anyway option if there exists a swap
autocmd SwapExists * let v:swapchoice = "e"

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

" Alternate between the last two files
nmap <silent><C-a> :w<CR>:e#<CR>
inoremap <silent><C-a> <C-[>:w<CR>:e#<CR>

" When using the / tool, it will not be sensitive case unless you write some case letters.
set ignorecase
set smartcase

"Auto reload files
set autoread 
au CursorHold * checktime 
au FocusGained,BufEnter * :silent! !

" Common clipboard between vim and the ubuntu system
set clipboard=unnamed
set clipboard=unnamedplus

" Color
highlight HighlightedyankRegion cterm=reverse gui=reverse

" Set tab to be 4 spaces (2 for lua)
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType lua setlocal shiftwidth=2 softtabstop=2 smarttab
autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2 smarttab

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
set nohlsearch " Avoid highlighting all words after /

" Close tabs with Ctrl + w 
cmap tclose tabclose 

" Alternate between source and header file
nmap <silent><C-x> :call CurtineIncSw()<CR>

" Split files by default at right and down
set splitbelow
set splitright

" Set directory of Ctrl + P
let g:ctrlp_cmd='CtrlP :pwd'
" When disabled, CtrlP won't visualize cache Which means that if a new file is created
" it will appear instantly
let g:ctrlp_use_caching=0

" Insert space and go to insert mode
nnoremap space i<space>

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
let g:winresizer_horiz_resize = 5
let g:winresizer_vert_resize = 5

" This line will make the window close after a file is chosen in grep style commands
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

if exists("did_load_csvfiletype")
  finish
endif
let did_load_csvfiletype=1

" Define filetype for CSV
augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
augroup END

" Replace mode
nmap S <Plug>(sad-change-forward)

" Delete entire word in insert mode
imap <C-d> <C-[>diwi
" Paste something yanked in insert mode
imap <C-v> <C-[>pi

" Toggle/Untoggle folds
map <silent><C-t> :call ToggleFoldDiff()<CR>

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
}
EOF

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


" QF default location: Very bottom
autocmd FileType qf wincmd J
" Adjust the quickfix height to the number of elemens. Maximum 10
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" To do list manager
let g:vimwiki_key_mappings =
  \ {
  \   'all_maps': 1,
  \   'global': 0,
  \   'headers': 0,
  \   'text_objs': 0,
  \   'table_format': 0,
  \   'table_mappings': 0,
  \   'lists': 0,
  \   'links': 1,
  \   'html': 0,
  \   'mouse': 0,
  \ }

set scrolloff=4 " Keep 4 lines below and above the cursor
let g:vimwiki_global_ext = 0

"nnoremap <silent><LocalLeader><LocalLeader> :call Swap_todo()<CR>
let g:mflova_todo_mode=0
function! Swap_todo()
    if expand('%:t') != ''
        write
    end
    if g:mflova_todo_mode == 0
        edit ~/vimwiki/index.wiki
        let g:mflova_todo_mode = 1
    else
        e#
        let g:mflova_todo_mode = 0
    endif
endfunction

" For glow (markdown visualizer)
let g:glow_border = "rounded"
" Spotify
nmap <silent><leader>ss :Spotify<CR>
nmap <silent><leader>sd :SpotifyDevices<CR>
nmap <silent><leader>s<Down> <Plug>(SpotifyPause)
nmap <silent><leader>s<Left> <Plug>(SpotifyPrev)
nmap <silent><leader>s<Right> <Plug>(SpotifySkip)

nmap <silent><leader>sa <Plug>(SpotifySkip)
nmap <silent><leader>s<Right> <Plug>(SpotifySkip)

" Imports
let s:git_cfg_path = s:vim_cfg_path . '/git.vim'
let s:testing_cfg_path = s:vim_cfg_path . '/testing.vim'
let s:lsp_cfg_path = s:vim_cfg_path . '/lsp.vim'
let s:linters_cfg_path = s:vim_cfg_path . '/linters.vim'
let s:ui_cfg_path = s:vim_cfg_path . '/ui.vim'
let s:cmp_cfg_path = s:vim_cfg_path . '/cmp.vim'
let s:refactor_cfg_path = s:vim_cfg_path . '/refactoring.vim'
let s:snippets_cfg_path = s:vim_cfg_path . '/snippets.vim'
let s:navigation_cfg_path = s:vim_cfg_path . '/navigation.vim'
let s:coding_cfg_path = s:vim_cfg_path . '/coding.vim'
let s:debugger_cfg_path = s:vim_cfg_path . '/debugger.vim'
let s:formatter_cfg_path = s:vim_cfg_path . '/formatter.vim'
let s:conditional_mapping = s:vim_cfg_path . '/conditional_mapping.vim'
let s:latex_mapping = s:vim_cfg_path . '/latex_mapping.vim'

exec 'source ' . s:git_cfg_path
exec 'source ' . s:testing_cfg_path
exec 'source ' . s:lsp_cfg_path
exec 'source ' . s:linters_cfg_path
exec 'source ' . s:ui_cfg_path
exec 'source ' . s:cmp_cfg_path
exec 'source ' . s:refactor_cfg_path
exec 'source ' . s:snippets_cfg_path
exec 'source ' . s:navigation_cfg_path
exec 'source ' . s:coding_cfg_path
exec 'source ' . s:debugger_cfg_path
exec 'source ' . s:formatter_cfg_path
exec 'source ' . s:conditional_mapping
exec 'source ' . s:latex_mapping
