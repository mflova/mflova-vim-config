nnoremap <silent><F2> :NvimTreeToggle<CR>
" Tag browser (LSP based)
nnoremap <silent><F4> :Vista!!<CR>  

" Go to word that breaks column 89
nnoremap <leader><Right> :call feedkeys("089lb")<CR>

" Telescope. Since it is slower than FZF, only ctrl p is defined here
nnoremap <silent><C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent><leader><C-p> :lua search_vimfiles()<CR>
nnoremap <silent><C-t> :lua require('telescope.builtin').buffers()<CR>
nnoremap <silent><C-b> :Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>
" Fzf remaps
nnoremap <silent><C-f> :Ag<Cr>
nnoremap <silent><C-g> :FZFFzm<cr>

" HOP
map <Leader>w :HopWord<Cr>
lua << EOF
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
vim.api.nvim_set_keymap('v', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
vim.api.nvim_set_keymap('o', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", {})
require'hop'.setup()

local stf = require("syntax-tree-surfer")
vim.keymap.set("n", "<leader>W", function() -- jump to all that you specify
	stf.targeted_jump({
		"function",
	  "if_statement",
		"else_clause",
		"else_statement",
		"elseif_statement",
		"for_statement",
		"while_statement",
		"switch_statement",
	})
end, opts)



EOF

" Set how the window appears in the FZF command
let g:fzf_layout = { 'down': '~35%' }

set termguicolors " this variable must be enabled for colors to be applied properly
" a list of groups can be" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 60
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_cursor_delay = 0

lua << EOF
function search_vimfiles()
    local home_dir = os.getenv('HOME')
    local vim_dir = home_dir .. '/mflova-linux-setup/mflova-vim-config/cfg'
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
    file_ignore_patterns = {"__init__.py"},
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

" Ignore some files in FZF
let $FZF_DEFAULT_COMMAND="fdfind --exclude={.pyc,.bag,.bag.info,build,tmp,__init__.py} --type f"  
