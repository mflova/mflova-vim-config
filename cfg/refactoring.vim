lua << EOF

--require('refactoring').setup({})

--vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
--vim.api.nvim_set_keymap("v", "<Leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
--vim.api.nvim_set_keymap("v", "<Leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

--require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode




EOF

noremap <leader>rr :call RopeRename()<CR>
noremap <leader>ru :call RopeUndo()<CR>
noremap <leader>rm :call RopeExtractMethod()<CR>
noremap <leader>rf :call RopeExtractMethod()<CR>
"nnoremap <silent><leader>rR <cmd>lua vim.lsp.buf.code_action()<CR>
"map <silent><leader>rr <cmd>lua require('telescope').extensions.refactoring.refactors()<CR>
