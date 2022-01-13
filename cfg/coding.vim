" Commenting line(s) with these two lines
vmap <silent> <Leader>cc :call ToggleCommentVisual()<CR>
nmap <silent> <Leader>cc :call ToggleCommentLine()<CR>

augroup runnable
    autocmd!
    autocmd filetype python,lua nmap <silent><Leader>cr :SnipRun<CR>
    autocmd filetype python,lua vmap <silent><Leader>cr :SnipRun<CR>
augroup END

nmap <silent><Leader>cR :SnipClose<CR>
vmap <silent><Leader>cR :SnipClose<CR>

let g:instantrst_is_on = 0
function ToggleInstantRst()
    if g:instantrst_is_on == 1
        silent! StopInstantRst
        let g:instantrst_is_on= 0
    else
        let l:git_root= system("git rev-parse --show-toplevel | tr -d '\\n'")
        " Paths where images might be located
        let g:instant_rst_additional_dirs = [l:git_root . "/doc/resources/",
                                            \l:git_root . "/docs/resources",
                                            \l:git_root . "/doc/images",
                                            \l:git_root . "/docs/images",
                                            \]
        silent! InstantRst
        let g:instantrst_is_on= 1
    end
endfunction

let g:instant_rst_browser = 'google-chrome'
augroup visualizable
    autocmd!
    autocmd filetype markdown nmap <silent><leader>cr :MarkdownPreviewToggle<CR>
    autocmd filetype rst nmap <silent><leader>cr :call ToggleInstantRst()<CR>
augroup END


function! OpenOther()
    if expand("%:e") == "cpp"
        exe "split" fnameescape(expand("%:p:r:s?src?include?").".hpp")
    elseif expand("%:e") == "h"
        exe "split" fnameescape(expand("%:p:r:s?include?src?").".cpp")
    endif
endfunction

"
" Fold multi-line Python comments into one line.
"
" Also maps the "-" key to toggle expansion and <C-f> to toggle all folding.
"
setlocal foldmethod=syntax
setlocal foldtext=FoldText()
setlocal fillchars=

map <buffer> - za
map <buffer> <C-f> :call ToggleFold()<CR>

let b:folded = 1

hi Folded     gui=bold cterm=bold guifg=cyan ctermfg=cyan guibg=NONE ctermbg=NONE

function! ToggleFold()
  if b:folded == 0
    exec "normal! zM"
    let b:folded = 1
  else
    exec "normal! zR"
    let b:folded = 0
  endif
endfunction

function! s:Strip(string)
  return substitute(a:string, '^[[:space:][:return:][:cntrl:]]\+\|[[:space:][:return:][:cntrl:]]\+$', '', '')
endfunction

" Extract the first line of a multi-line comment to use as the fold snippet
function! FoldText()
  let l:snippet = getline(v:foldstart)
  if len(s:Strip(l:snippet)) == 3
    let l:snippet = strpart(l:snippet, 1) . s:Strip(getline(v:foldstart + 1))
  endif
  return '+' . l:snippet . ' ...'
endfunction
