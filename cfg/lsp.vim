lua << EOF
require'lspconfig'.pyright.setup{}


--local lspconfig = require'lspconfig'
--lspconfig.ccls.setup {
 -- init_options = {
 --   compilationDatabaseDirectory = '/home/manuflya/flyability/build_gaston/build';
 --   index = {
 --     threads = 0;
 --   };
 --   clang = {
--      extraArgs= { '-Weverything', '-Wall', '-Wextra', '-Wdocumentation', '-Wno-missing-prototypes'} ;
 --   };
--  }
--}

-- Disable underline in diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
 vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    update_in_insert = true,
  }
)

EOF

"
"if executable('pylsp')
    " pip install python-language-server
"    au User lsp_setup call lsp#register_server({
"          \ 'name': 'pyls',
"          \ 'cmd': {server_info->['pyls']},
"          \ 'allowlist': ['python'],
"          \ 'workspace_config': {
"          \    'pyls':
"          \        {'configurationSources': ['flake8'],
"          \         'plugins': {'flake8': {'enabled': v:true},
"          \                     'pyflakes': {'enabled': v:false},
"          \                     'pycodestyle': {'enabled': v:true},
"          \                    }
"          \         }
"          \ }})
"endif
"
