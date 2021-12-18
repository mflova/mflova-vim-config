" ALE CONFIG (Used for its linters)
"
" PARAMS
"
" Enabled at startup by default. Only read at startup
let g:ale_enabled = 1
" Constants defined for the vim airline status bar when the ale linters are
" ON/OFF. Shown in the vim-airline warning section
let g:mflova_linters_on = ''
let g:mflova_linters_off = 'LINTERS OFF'
" Files where ALE is disabled
autocmd BufEnter TODO.md exe "call ALETemporaryDisable()"
autocmd BufEnter NOTES.md exe "call ALETemporaryDisable()"
autocmd BufLeave TODO.md exe "call ALERestoreStatus()"
autocmd BufLeave NOTES.md exe "call ALERestoreStatus()"

nnoremap <silent><Leader>at :call ALEToggleWrapper()<CR>
nnoremap <silent><Leader>af :ALEFix<CR>
nnoremap <silent><Leader>ad :ALEGoToDefinition<CR>
nnoremap <silent><Leader>ar :ALEFindReferences<CR>
nnoremap <silent><Leader>as :call Genstubs()<CR>
" This one uses Pyright because of the LSP
nnoremap <silent><Leader>ah :ALEHover<CR>

" LINTERS CONFIG SECTION
let g:ale_fixers = ['autopep8']
let g:ale_python_autopep8_options = '--max-line-length 90'
" Dictionary that maps languages with linters. Only Python has been added so far
" Flake8 Plugins Installed:
"    - darglint -> Errors at docstrings
"    - pytest style -> Extra functions for pytest for better code
"    - flake8-simplify -> Simplify code
"    - flake8-bugbear -> Detecting bugs
"    - dlint -> Security stuff. It might be annoying
"    - comprehensions -> Comprehension stuff (list, set, dicts...)
"    - flake8-commas -> Check for missing trailing commas
"    - flake8-rst-docstrings -> rst docstring checker
"    - flake8-markdown -> Checks for python code blocks in .md
"    - flake8-builtins -> Checks builtins collision names
"    - flake8-broken-line -> Improves broken lines style with backslash
"    - flake8-class-attributes-order -> Checks order the attributes of a class
"                   \ 'python': ['pylint', 'mypy', 'pydocstyle', 'vulture', 'flake8'],
let g:ale_linters = {
                   \ 'python': ['pylint', 'mypy', 'pydocstyle', 'vulture', 'flake8', 'pyright'],
                   \ 'rst': ['proselint', 'rstcheck'],
                   \ 'yaml': ['yamllint'],
                   \ 'cmake': ['cmakelint'],
                   \ 'cpp': ['clangtidy'],
                   \ 'markdown': ['mdl']}
" Ignoring specific warnings/errors. Strict one forces you to write always the optional typing
let g:ale_python_mypy_options = '--strict'
" Those variables with less than 3 characteres and not in this list will be considered as warning
let g:ale_python_pylint_options = '--good-names="q1, q2, q3, q4, q5, q, i, j, k, df, dt" --disable="W0102, W0212, R0913, R0903, R0902, R0914, W0621"'
" Some plugins were integrated into flake8. Install with pip the following
" ones:
let g:ale_python_flake8_options = ' --docstring-style sphinx --max-line-length=90 --indenxt-size=4' 
let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length:{max: 90}}}"' 
let g:ale_cmake_cmakelint_options = '--linelength=120' 
let g:ale_cpp_cpplint_options = '--linelength=90 --filter="-legal/copyright, -whitespace/braces, -whitespace/newline"'  " The brace ones are ignore due to personal change in style
let g:ale_cpp_cppcheck_options = '--std="c++17"' 
let g:ale_cpp_clangtidy_options = '--format-style="google"' 
let g:ale_markdown_mdl_options = '--rules MD001,MD002,MD003,MD004,MD005,MD006,MD007,MD009,MD010,MD011,MD012,MD013,MD014,MD018,MD019,MD020,MD021,MD022,MD023,MD024,MD025,MD026,MD027,MD028,MD030,MD031,MD032,MD033,MD034,MD035,MD036,MD037,MD038,MD039,MD040,MD041,MD046,MD047' " Just wanted to ignore one rule...
" Update the messages printed in the status bar to show the liner, the message and the severity
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" OWN FUNCTIONS
let g:is_ale_running = g:ale_enabled
if g:ale_enabled
    let g:ale_status_bar = g:mflova_linters_on
else
    let g:ale_status_bar = g:mflova_linters_off
endif

let g:airline_section_warning = '%{g:ale_status_bar}'


" Function that not only toggles ALE but also its message to be printed in vim
" airline
function! ALEToggleWrapper()
    if g:is_ale_running
        let g:ale_status_bar = g:mflova_linters_off
        let g:is_ale_running = 0
    else
        let g:ale_status_bar = g:mflova_linters_on
        let g:is_ale_running = 1
    endif
    ALEToggle
endfunction

" Save the status when entering in a special file
let g:mflova_ale_prev_status = g:is_ale_running
function! ALETemporaryDisable()
    let g:mflova_ale_prev_status = g:is_ale_running
    let g:ale_status_bar = g:mflova_linters_off
    ALEDisable
endfunction

" Restore the saved status
function! ALERestoreStatus()
    if g:mflova_ale_prev_status == 1
        let g:ale_status_bar = g:mflova_linters_on
        ALEEnable
    endif
endfunction


" Stubs stuff: Generates the ones in the cursor with the Genstubs command
command! -nargs=1 RunCMDSilent execute ':silent !'.<q-args> | execute ':redraw!'
function! Genstubs()
    let l:line = getline('.')
    let l:words = split(l:line, '[ .]')
    let g:mflova_stubgen_args = 'stubgen -o $MYPYPATH '
    if l:words[0] == "import"
"    Case1: Import XXX (as XXX) -m XXX 
        if l:words[2] == "as"
            let g:mflova_stubgen_args = g:mflova_stubgen_args . '-m ' . l:words[1]
"    Case2: Import XXX.XXX.XXX -p XXX (first)
        else
            let g:mflova_stubgen_args = g:mflova_stubgen_args . '-p ' . l:words[1]
        endif
    endif
"    Case3: From XXX.XXX.XXX import XXX -p XXX (the first one)
    if l:words[0] == "from"
        let g:mflova_stubgen_args = g:mflova_stubgen_args . '-p ' . l:words[1]
    endif
    execute ':RunCMDSilent ' . g:mflova_stubgen_args
endfunction
