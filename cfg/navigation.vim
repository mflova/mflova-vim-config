nnoremap <F2> :NvimTreeToggle<CR>
" Tag browser (LSP based)
nnoremap <F4> :Vista!!<CR>  

" Go to word that breaks column 89
nnoremap <leader><Right> :call feedkeys("089lb")<CR>

" Telescope. Since it is slower than FZF, only ctrl p is defined here
nnoremap <silent><C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent><leader><C-p> :lua search_vimfiles()<CR>
nnoremap <silent><C-f> :lua require('telescope.builtin').tags()<CR>
nnoremap <silent><C-t> :lua require('telescope.builtin').current_buffer_tags()<CR>
nnoremap <silent><C-b> :Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>
" Fzf remaps
nnoremap <silent><C-g> :Ag<Cr>
nnoremap <silent><C-h> :w<cr>:Changes<cr>

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

" Set how the window appears in the FZF command
let g:fzf_layout = { 'down': '~35%' }

set termguicolors " this variable must be enabled for colors to be applied properly
" a list of groups can be" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 40
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_cursor_delay = 0

lua << EOF
function search_vimfiles()
    local home_dir = os.getenv('HOME')
    local vim_dir = home_dir .. '/mflova-linux-setup/mflova-vim-config'
    require('telescope.builtin').find_files({
        prompt_title = "< VimRC >",
        cwd = vim_dir,
        })
end

-- File explorer
require'nvim-tree'.setup()

local actions = require "telescope.actions"
require('telescope').setup({
  defaults = {
    mappings = {
        i = {
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        }
    },
    -- other defaults configuration here
  },
  -- other configuration values here
})
EOF

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


" Updates BLines command from FZF to have the preview window. Note: Needs ripgrep to be installed
command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%'))
    " \   fzf#vim#with_preview({'options': '--layout reverse  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))
    "
" Customize fzf colors to match your color scheme                                          
" - fzf#wrap translates this to a set of `--color` options                                 
let g:fzf_colors =                                                                         
\ { 'fg':      ['fg', 'Normal'],                                                           
  \ 'bg':      ['bg', 'Normal'],                                                           
  \ 'hl':      ['fg', 'Comment'],                                                          
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
  \ 'hl+':     ['fg', 'Statement'],                                                        
  \ 'info':    ['fg', 'PreProc'],                                                          
  \ 'border':  ['fg', 'Ignore'],                                                           
  \ 'prompt':  ['fg', 'Conditional'],                                                      
  \ 'pointer': ['fg', 'Exception'],                                                        
  \ 'marker':  ['fg', 'Keyword'],                                                          
  \ 'spinner': ['fg', 'Label'],                                                            
  \ 'header':  ['fg', 'Comment'] } 

function GoTo(jumpline)
  let values = split(a:jumpline, ":")
  execute "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal zvzz"
endfunction

function GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction

function! Changes()
  let changes  = reverse(copy(getchangelist()[0]))

  let changetext = map(copy(changes), { index, val -> 
      \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.GetLine(bufnr('%'), val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': changetext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction

command! Changes call Changes()

" Ignore some files in FZF
let $FZF_DEFAULT_COMMAND="fdfind --exclude={.pyc,.bag,.bag.info,build,tmp,__init__.py} --type f"  
