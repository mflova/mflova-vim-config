" Git integration
" Loads the enhanced version of the diff from a plugin
autocmd VimEnter * PatienceDiff
" Introduces Git diff from fugitive (used below in a command)
command! -bar Gclogfunc execute '.Gclog -L :' . expand('<cword>') . ':%'
" Zr means that by default, the diff will be fully unfolded
" Opens the window at minimum height
map <silent><Leader>gs :G<CR>:call AdjustWindowHeight(15,99)<CR> 
map <silent><Leader>gdf :Gvdiffsplit<CR>zR 
map <silent><Leader>gDF :DiffviewOpen<CR>
map <silent><Leader>gdd :Gvdiffsplit develop<CR>zR
map <silent><Leader>gdm :Gvdiffsplit main<CR>zR
map <silent><Leader>gDD :DiffviewOpen develop<CR>
map <silent><Leader>gDM :DiffviewOpen main<CR>
map <silent><Leader>gl :DiffviewFileHistory<CR>
map <silent><Leader>gh :Gclogfunc<CR>
map <silent><Leader>gS :GStash<CR>
map <silent><Leader>gb :GBranches --locals<CR>
map <silent><Leader>gB :GBranches<CR>
map <silent><Leader>gc :call Commitizen()<CR>
map <silent><Leader>gP :Git push<CR>
map <silent><Leader>gPP :Git push --no-verify<CR>
map <silent><Leader>gL :Flog -all<CR>
" As merge tool: gets from left and right
nmap <silent><leader>g<Right> :diffget //3<CR>
nmap <silent><leader>g<Left> :diffget //2<CR>

map <silent><Leader>gpp :Octo pr checks<CR>
map <silent><Leader>gpr :Octo pr reload<CR>
map <silent><Leader>gpl :Octo pr list<CR>
map <silent><Leader>gpc :Octo pr commits<CR>
map <silent><Leader>gpb :Octo pr browser<CR>
map <silent><Leader>gpn :Octo pr create<CR>
map <silent><Leader>gpm :Octo pr merge squash delete<CR>

map <silent><Leader>grs :Octo review start<CR>
map <silent><Leader>grc :Octo review close<CR>
map <silent><Leader>grr :Octo review resume<CR>
map <silent><Leader>gr<CR> :Octo review submit<CR>
map <silent><Leader>grd :Octo review discard<CR>
map <silent><Leader>grC :Octo review comments<CR>

map <silent><Leader>gtr :Octo thread resolve<CR>
map <silent><Leader>gtu :Octo thread unresolve<CR>

" Vertical split by default
set diffopt+=vertical

" Update all buffers after a gitcommit. Applied whenever a git rebase
" --continue is called to update the diff markers in the buffers.
autocmd Filetype gitcommit call UpdateBuffers()
set noconfirm
function! UpdateBuffers()
    call fugitive#DiffClose()
endfunction

function! Commitizen()
    execute ':RunCMDSilent ' . 'cz commit'
endfunction

" The default configuration
let g:fuzzy_stash_actions = {
  \ 'ctrl-d': 'drop',
  \ 'ctrl-p': 'pop',
  \ 'enter': 'apply',
  \ 'ctrl-k': 'keep',
  \ 'ctrl-s': 'push'}

let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Gvdiffsplit {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'force checkout': {
      \   'prompt': 'FCheckout> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout -f {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'alt-enter',
      \   'required': ['branch'],
      \   'confirm': v:true,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'interactive rebase': {
      \   'prompt': 'int-rebase> ',
      \   'execute': 'Git rebase --interactive {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}


" Diffview config
lua <<EOF
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<A-Down>"]         = cb("select_next_entry"),
      ["<A-Up>"]       = cb("select_prev_entry"),
    },
    file_panel = {
      ["<A-Down>"]         = cb("select_next_entry"),
      ["<A-Up>"]       = cb("select_prev_entry"),
    },
    file_history_panel = {
      ["<A-Down>"]         = cb("select_next_entry"),
      ["<A-Up>"]       = cb("select_prev_entry"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}
EOF
