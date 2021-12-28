" ALE CONFIG (Used for its linters)
"
" PARAMS
"
" Enabled at startup by default. Only read at startup
"let g:ale_enabled = 0
" Constants defined for the vim airline status bar when the ale linters are
" ON/OFF. Shown in the vim-airline warning section
"let g:mflova_linters_on = ''
"let g:mflova_linters_off = 'LINTERS OFF'
" Main parameters for each programming language
let g:mflova_python_max_line_length = '90'
let g:mflova_python_indent_size = '4'
let g:mflova_python_docstring_style= 'sphinx'
" C++ TODO:TO BE CONFIGURED
let g:mflova_cpp_max_line_length = '90'
" CMake
let g:mflova_cmake_max_line_length = '90'
" Yaml
let g:mflova_yaml_max_line_length = '90'

" Files where ALE is disabled
"autocmd BufEnter TODO.md exe "call ALETemporaryDisable()"
"autocmd BufEnter NOTES.md exe "call ALETemporaryDisable()"
"autocmd BufLeave TODO.md exe "call ALERestoreStatus()"
"autocmd BufLeave NOTES.md exe "call ALERestoreStatus()"

"nnoremap <silent><Leader>at :call ALEToggleWrapper()<CR>
"nnoremap <silent><Leader>af :ALEFix<CR>
"nnoremap <silent><Leader>ad :ALEGoToDefinition<CR>
"nnoremap <silent><Leader>ar :ALEFindReferences<CR>
"nnoremap <silent><Leader>as :call Genstubs()<CR>
" This one uses Pyright because of the LSP
"nnoremap <silent><Leader>ah :ALEHover<CR>

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
                   \ 'rst': ['proselint', 'rstcheck'],
                   \ 'cmake': ['cmakelint'],
                   \ 'cpp': ['clangtidy']}
" Ignoring specific warnings/errors. Strict one forces you to write always the optional typing
"let g:ale_python_mypy_options = '--strict'
" Those variables with less than 3 characteres and not in this list will be considered as warning
"let g:ale_python_pylint_options = '--good-names="q1, q2, q3, q4, q5, q, i, j, k, df, dt" --disable="W0102, W0212, R0913, R0903, R0902, R0914, W0621"'
" Some plugins were integrated into flake8. Install with pip the following
" ones:
"let g:ale_python_flake8_options = ' --docstring-style=' . g:mflova_python_docstring_style . ' --max-line-length=' . g:mflova_python_max_line_length . ' --indent-size=4 --ignore="DAR402"' 
let g:ale_cmake_cmakelint_options = '--linelength='  .  g:mflova_cmake_max_line_length
let g:ale_cpp_cpplint_options = '--linelength=' . g:mflova_cpp_max_line_length . ' --filter="-legal/copyright, -whitespace/braces, -whitespace/newline"'  " The brace ones are ignore due to personal change in style
let g:ale_cpp_cppcheck_options = '--std="c++17"' 
let g:ale_cpp_clangtidy_options = '--format-style="google"' 
" Update the messages printed in the status bar to show the liner, the message and the severity
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"
" OWN FUNCTIONS
"let g:is_ale_running = g:ale_enabled
"if g:ale_enabled
"    let g:ale_status_bar = g:mflova_linters_on
"else
"    let g:ale_status_bar = g:mflova_linters_off
"endif
"
"let g:airline_section_warning = '%{g:ale_status_bar}'
"
"
" Function that not only toggles ALE but also its message to be printed in vim
" airline
"function! ALEToggleWrapper()
"    if g:is_ale_running
"        let g:ale_status_bar = g:mflova_linters_off
"        let g:is_ale_running = 0
"    else
"        let g:ale_status_bar = g:mflova_linters_on
"        let g:is_ale_running = 1
"    endif
"    ALEToggle
"endfunction
"
" Save the status when entering in a special file
"let g:mflova_ale_prev_status = g:is_ale_running
"function! ALETemporaryDisable()
"    let g:mflova_ale_prev_status = g:is_ale_running
"    let g:ale_status_bar = g:mflova_linters_off
"    ALEDisable
"endfunction
"
" Restore the saved status
"function! ALERestoreStatus()
"    if g:mflova_ale_prev_status == 1
"        let g:ale_status_bar = g:mflova_linters_on
"        ALEEnable
"    endif
"endfunction
"

