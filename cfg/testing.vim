" Testing mode
nmap <silent><leader>tt :call Toggle_test_mode(0)<CR> 
nmap <silent><leader>tT :call Toggle_test_mode(1)<CR> 
nmap <silent><leader>tr :UltestLast<CR> 
" Activate clors in the output. Kinda experimental
let g:ultest_use_pty=1
let g:ultest_running_sign='~'
let g:ultest_summary_width=70

let g:mflova_test_mode = 0

" Two modes:
" 0: Run all test + runs the nearest after sving
" 1: 0 mode + Opens summary (vertical and unfolded if enough space, otherwise
" down and unfolded)
function! Toggle_test_mode(open_summary)

    if g:mflova_test_mode == 1
        let g:mflova_test_mode = 0
        UltestStop
        UltestSummaryClose
        UltestClear
        autocmd! UltestRunner
        echo "Test mode disabled"
    else
        let g:mflova_test_mode = 1
        Ultest
        if a:open_summary
            let g:mflova_curr_win_width = winwidth(0)
            if g:mflova_curr_win_width > 120
            "   Open vertical
                let g:ultest_summary_open = 'botright vsplit | vertical resize' .g:ultest_summary_width
                UltestSummaryOpen!
                call feedkeys("\zR")
                call feedkeys("\<C-W>h")
            else
            "   Open horizontal
                let g:ultest_summary_open = 'botright split'
                UltestSummaryOpen!
                " Minimum height
                call AdjustWindowHeight(3,10)
                call feedkeys("\zR")
                call feedkeys("\<C-W>k")
            endif
        endif
        echo "Test mode enabled"
        augroup UltestRunner
            au!
            au BufWritePost * UltestNearest
        augroup ENDltestSummary
    endif 
endfunction
