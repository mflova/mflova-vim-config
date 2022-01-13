augroup debuggable
    autocmd!
    autocmd filetype python nmap <silent><leader>dd :lua require("dapui").toggle()<CR>
    autocmd filetype python nmap <silent><leader>db :lua require'dap'.toggle_breakpoint()<CR>
    autocmd filetype python nmap <silent><leader>d<leader> :lua require'dap'.continue()<CR>
    autocmd filetype python nmap <silent><leader>dc :lua require'dap'.continue()<CR>

    autocmd filetype python nmap <silent><leader>d<Right> :lua require'dap'.step_over()<CR>
    autocmd filetype python nmap <silent><leader>d<Down> :lua require'dap'.step_into()<CR>
    autocmd filetype python nmap <silent><leader>d<Up> :lua require'dap'.step_out()<CR>

    " For pytest
    autocmd filetype python nnoremap <silent><leader>dt :lua require('dap-python').test_method()<CR>
    autocmd filetype python nnoremap <silent><leader>da :lua require('dap-python').test_class()<CR>
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
