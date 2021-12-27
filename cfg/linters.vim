" Diagnotics params
let g:diagnostics_enabled = 1
let g:mflova_diagnostics_on = ''
let g:mflova_diagnostics_off = 'DIAGS OFF'

" Files that will disable the diagnos messages
autocmd BufEnter TODO.md exe "call DiagnosTemporaryDisable()"
autocmd BufEnter NOTES.md exe "call DiagnosTemporaryDisable()"
autocmd BufLeave TODO.md exe "call DiagnosRestoreStatus()"
autocmd BufLeave NOTES.md exe "call DiagnosRestoreStatus()"

" Mapping
nnoremap <silent><leader>dt :call ToggleDiagWrapper()<CR>
nnoremap <silent><Leader>ds :call Genstubs()<CR>

lua << EOF
-- Python params
local python_max_line_length = 90
local python_indent_size = 4
local python_docstring_style = 'sphinx'

require('lint').linters.flake8.args = {'--docstring-style', python_docstring_style, 
                                       '--max-line-length', python_max_line_length,
                                       '--indent-size', python_indent_size,
                                       '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
                                       '--no-show-source',
                                       '-',}

require('lint').linters.mypy.args = {'--strict',
                                     '--show-column-numbers',
                                     '--hide-error-codes',
                                     '--hide-error-context',
                                     '--no-color-output',
                                     '--no-error-summary',
                                     '--no-pretty',}

require('lint').linters.pylint.args = {'--good-names', 'q1, q2, q3, q4, q5, q, i, j, k, df, dt',
                                       '--disable', 'W0102, W0212, R0913, R0903, R0902, R0914, W0621',
                                       '-f', 'json',}

require('lint').linters_by_ft = {
  python = {'flake8', 'mypy', 'pylint', 'vulture'}
}
-- To toggle the diags 
EOF


" Generate stubs when the cursor is on the import/from
function! Genstubs()
    let l:line = getline('.')
    let l:words = split(l:line, '[ .]')
    let l:stubgen_args = 'stubgen -o $MYPYPATH '
    if l:words[0] == "import"
"    Case1: Import XXX (as XXX) -m XXX 
        if l:words[2] == "as"
            let l:stubgen_args = l:stubgen_args . '-m ' . l:words[1]
"    Case2: Import XXX.XXX.XXX -p XXX (first)
        else
            let l:stubgen_args = l:stubgen_args . '-p ' . l:words[1]
        endif
    endif
"    Case3: From XXX.XXX.XXX import XXX -p XXX (the first one)
    if l:words[0] == "from"
        let l:stubgen_args = l:stubgen_args . '-p ' . l:words[1]
    endif
    echo l:stubgen_args
    execute ':RunCMDSilent ' . l:stubgen_args
endfunction

" Init the status bar with the diagnos ON/OFF
if g:diagnostics_enabled
   let g:diagnos_status_bar = g:mflova_diagnostics_on
else
   let g:diagnos_status_bar = g:mflova_diagnostics_off
endif

" Changes the status bar when toggled bar
function! ToggleDiagWrapper()
    if g:diagnostics_enabled
        let g:diagnos_status_bar = g:mflova_diagnostics_off
        let g:diagnostics_enabled = 0
    else
        let g:diagnos_status_bar = g:mflova_diagnostics_on
        let g:diagnostics_enabled = 1
    endif
    ToggleDiag
endfunction
let g:airline_section_warning = '%{g:diagnos_status_bar}'

" Save the status when entering in a special file
let g:mflova_diagnos_prev_status = g:diagnostics_enabled
function! DiagnosTemporaryDisable()
    let g:mflova_diagnos_prev_status = g:diagnostics_enabled
    let g:diagnos_status_bar = g:mflova_diagnostics_off
    ToggleDiagOff
endfunction

" Restore the saved status
function! DiagnosRestoreStatus()
    if g:mflova_diagnos_prev_status == 1
        let g:diagnos_status_bar = g:mflova_diagnostics_on
        ToggleDiagOn
    endif
endfunction
