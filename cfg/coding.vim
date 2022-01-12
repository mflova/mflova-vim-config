" Commenting line(s) with these two lines
vmap <silent> <Leader>cc :call ToggleCommentVisual()<CR>
nmap <silent> <Leader>cc :call ToggleCommentLine()<CR>

nmap <silent><Leader>cr :SnipRun<CR>
vmap <silent><Leader>cr :SnipRun<CR>

nmap <silent><Leader>cR :SnipClose<CR>
vmap <silent><Leader>cR :SnipClose<CR>

function! OpenOther()
    if expand("%:e") == "cpp"
        exe "split" fnameescape(expand("%:p:r:s?src?include?").".hpp")
    elseif expand("%:e") == "h"
        exe "split" fnameescape(expand("%:p:r:s?include?src?").".cpp")
    endif
endfunction
