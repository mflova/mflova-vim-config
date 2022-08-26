let g:mflova_debug_mode = 0
augroup debuggable
    autocmd!
    autocmd filetype python nmap <silent><leader>dd :call Toggle_debug_mode()<CR>
    autocmd filetype python nmap <silent><leader>db :lua require'dap'.toggle_breakpoint()<CR>
    autocmd filetype python nmap <silent><leader>d<leader> :lua require'dap'.continue()<CR>
    autocmd filetype python nmap <silent><leader>dc :lua require'dap'.continue()<CR>

    " Compatible with Ctrl + arrows if in debug mode
    autocmd filetype python nmap <silent><leader>d<Down> :lua require'dap'.step_over()<CR>
    autocmd filetype python nmap <silent><leader>d<Right> :lua require'dap'.step_into()<CR>
    autocmd filetype python nmap <silent><leader>d<Up> :lua require'dap'.step_out()<CR>

    " For pytest
    autocmd filetype python nnoremap <silent><leader>dt :call Debug_mode(1)<CR> :lua require("neotest").run.run({strategy = "dap"})<CR>
    autocmd filetype python nnoremap <silent><leader>dT :call Debug_mode(1)<CR> :lua require("neotest").run.run({strategy = "dap"})<CR>
augroup END

lua << EOF
-- This variable can be check with pip show debugpy, in Location
local python_path = os.getenv('PYTHON_DIR')
require('dap-python').setup(python_path)
require('dap-python').test_runner = 'pytest'

-- Enable virtual text
require("nvim-dap-virtual-text").setup()

-- UI (mainly removed the REPL window in the default config)
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "watches", size = 00.25 },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { },

  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- Icons and customization of DAP
require('dap')
vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointConditionRejected', {text='', texthl='', linehl='', numhl=''})
-- `DapBreakpoint` which defaults to `B` for breakpoints
-- `DapBreakpointCondition` which defaults to `C` for conditional breakpoints
-- `DapLogPoint` which defaults to `L` and is for log-points
-- `DapStopped` which defaults to `→` and is used to indicate the position where
--  the debugee is stopped.
-- `DapBreakpointRejected`, defaults to `R` for breakpoints which the debug
--  adapter rejected.
EOF

" It detects if the file is test_ to run the function with the reequired
" command
function! Run_debug()
    let l:name = expand('%:t')
    let l:is_test = l:name[0:len("test_")-1] ==# "test_"
    if l:is_test == 1
        lua require('dap-python').test_method()
    else
        
    endif
endfunction

" It uses Ctrl w + o to close the debugger mode instead of toggle
function! Toggle_debug_mode()

    if g:mflova_debug_mode == 0
        call Debug_mode(1)
    else
        call Debug_mode(0)
    endif 
endfunction

function! Debug_mode(mode)
    if a:mode
        if g:mflova_test_mode
            call Toggle_test_mode(0)
        endif
        if g:mflova_debug_mode
            return
        endif
        let g:mflova_debug_mode = 1
        lua require("dapui").open()
        echo "Debug mode enabled"
    else
        if g:mflova_debug_mode ==? 0
            return
        endif
       " Close all splits but the main one
        let g:mflova_debug_mode = 0
        execute "normal \<C-W>o"
        call ClearBreakpoints()
        echo "Debug mode disabled"
    endif
endfunction

function! ClearBreakpoints() 
    exec "lua require'dap'.list_breakpoints()"
    for item in getqflist()
        exec "exe " . item.lnum . "|lua require'dap'.toggle_breakpoint()"
    endfor
endfunction
