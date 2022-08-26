nmap <silent><leader>tT :call Toggle_test_mode(0)<CR> 
nmap <silent><leader>tt :call Toggle_test_mode(1)<CR> 

let g:mflova_test_mode = 0

lua <<EOF

require("neotest").setup({
  adapters = {
    require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        dap = { justMyCode = false },
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = {"--log-level", "DEBUG"},
        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",
        -- Custom python path for the runner.
        -- Can be a string or a list of strings.
        -- Can also be a function to return dynamic value.
        -- If not provided, the path will be inferred by checking for 
        -- virtual envs in the local directory and for Pipenev/Poetry configs
        python = "/usr/bin/python3",
        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
    })
  },
  icons = {
  child_indent = "│",
  child_prefix = "├",
  collapsed = "─",
  expanded = "╮",
  failed = "✖",
  final_child_indent = " ",
  final_child_prefix = "╰",
  non_collapsible = "─",
  passed = "✔",
  running = "~",
  skipped = "ﰸ",
  unknown = "?"
},
})

vim.cmd([[
command! NeotestSummary lua require("neotest").summary.toggle()
command! NeotestSummaryOpen lua require("neotest").summary.open({width=240})
command! NeotestSummaryClose lua require("neotest").summary.close()
command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%"))
command! Neotest lua require("neotest").run.run(vim.fn.getcwd())
command! NeotestNearest lua require("neotest").run.run()
command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" })
command! NeotestAttach lua require("neotest").run.attach()
command! NeotestClear lua require("neotest").summary.clear_marked()
command! NeotestStop lua require("neotest").run.stop()
]])

EOF

function! Toggle_test_mode(open_summary)

    if g:mflova_test_mode == 1
        let g:mflova_test_mode = 0
        NeotestStop
        NeotestSummaryClose
        NeotestClear
        autocmd! NeotestRunner
        echo "Test mode disabled"
    else
        NeotestFile
        NeotestSummaryOpen
        if g:mflova_debug_mode
            call Debug_mode(0)
        endif
        let g:mflova_test_mode = 1
        echo "Test mode enabled"
        augroup NeotestRunner
            au!
            au BufWritePost * NeotestNearest
        augroup ENDltestSummary
    endif 
endfunction

