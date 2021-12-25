" Git integration
" Loads the enhanced version of the diff from a plugin
autocmd VimEnter * PatienceDiff
" Introduces Git diff from fugitive (used below in a command)
command! -bar Gclogfunc execute '.Gclog -L :' . expand('<cword>') . ':%'
" Zr means that by default, the diff will be fully unfolded
" Opens the window at minimum height
map <silent><Leader>gs :G<CR>:call AdjustWindowHeight(3,99)<CR> 
map <silent><Leader>gdf :Gvdiffsplit<CR>zR 
map <silent><Leader>gdd :Gvdiffsplit develop<CR>zR
map <silent><Leader>gdm :Gvdiffsplit master<CR>zR
map <silent><Leader>t :call ToggleFoldDiff()<CR>
map <silent><Leader>gH :BCommits<CR>
map <silent><Leader>gh :Gclogfunc<CR>
map <silent><Leader>gt :GStash<CR>
map <silent><Leader>gb :GBranches --locals<CR>
map <silent><Leader>gB :GBranches<CR>
map <silent><Leader>gc :call Commitizen()<CR>
map <silent><Leader>gp :Git push<CR>
map <silent><Leader>gv :GV<CR>
" As merge tool: gets from left and right
nmap <silent><leader>g<Right> :diffget //3<CR>
nmap <silent><leader>g<Left> :diffget //2<CR>

set diffopt+=vertical

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
      \}
