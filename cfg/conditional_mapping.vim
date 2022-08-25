map <silent><A-Up> :call ConditionalArrows('up')<CR>
map <silent><A-Down> :call ConditionalArrows('down')<CR>
map <silent><A-Right> :call ConditionalArrows('right')<CR>
map <silent><A-Left> :call ConditionalArrows('left')<CR>

map <silent><C-Up> 2k
map <silent><C-Down> 2j
map <silent><C-Right> w
map <silent><C-Left> b

" Ctrl + arrows change behaviour depending on context
function! ConditionalArrows(map)
    " Debug mode enabled
    if g:mflova_debug_mode
        if a:map ==? 'up'
            lua require'dap'.step_out()
            return
        elseif a:map ==? 'down'
            lua require'dap'.step_over()
            return
        elseif a:map ==? 'right'
            lua require'dap'.step_into()
            return
        elseif a:map ==? 'left'
            lua require'dap'.continue()
            return
        endif
    endif

    if g:mflova_test_mode
        if a:map ==? 'up'
            execute "normal \<Plug>(ultest-prev-fail)"
            return
        elseif a:map ==? 'down'
            execute "normal \<Plug>(ultest-next-fail)"
            return
        elseif a:map ==? 'right'
            execute "normal \<Plug>(ultest-output-jump)"
            return
        endif
    endif

    " QF open
    for winnr in range(1, winnr('$'))
        let l:qf = getwinvar(winnr, '&syntax') ==? 'qf'
    endfor
    if l:qf
        if a:map ==? 'up'
            cp
            return
        elseif a:map ==? 'down'
            cn
            return
        endif
    endif

    " Diffviewmap
    if (&ft ==? "DiffviewFiles" || &ft ==? "DiffviewFileHistory")
        if a:map ==? 'left'
            execute  "DiffviewClose"
            return
        endif
    endif

    if (&ft ==? "tex")
        if a:map ==? 'right'
            execute  "VimtexView"
            return
        endif
    endif
    " Standard behaviour (GIT conflicts)
    if a:map ==? 'up'
        call feedkeys('[c')
    elseif a:map ==? 'down'
        call feedkeys(']c')
    elseif a:map ==? 'right'
        diffget //3
    elseif a:map ==? 'left'
        diffget //2
    endif
endfunction

