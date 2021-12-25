" Fzf remaps
nnoremap <silent><C-p> :Files<Cr>
nnoremap <silent><C-g> :Ag<Cr>
nnoremap <silent><C-b> :BLines<CR>
nnoremap <silent><C-f> :BTags<CR>
nnoremap <silent><C-t> :Tags<CR>
nnoremap <silent><C-h> :Changes<cr>
" Set how the window appears in the FZF command
let g:fzf_layout = { 'down': '~35%' }
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

command! Changes call Changes()
