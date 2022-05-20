let g:current_formatter_state = 1  " defines the initial status of formatter

nnoremap <silent><leader>lf :call ToggleFormatterState()<CR>
" Python formater
let g:black#settings = {
    \ 'fast': 1,
    \ 'line_length': 90
\}



if g:current_formatter_state == 1
    augroup formatter
        autocmd!
        au BufWritePost *.py call Black()
    augroup END
else
    augroup foo
        autocmd!
    augroup END
endif



let g:mflova_formatter_status = g:current_formatter_state
function ToggleFormatterState()
    if g:current_formatter_state == 1
        autocmd! formatter
        let g:current_formatter_state = 0
    elseif g:current_formatter_state == 0
        let g:current_formatter_state = 1
        augroup formatter
            autocmd!
            au BufWritePost *.py call Black()
        augroup END
    end
    " Update status line
    let g:mflova_formatter_status = g:current_formatter_state
endfunction
