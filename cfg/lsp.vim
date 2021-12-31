" Autocomplete
set completeopt=menu,menuone,noselect

lua << EOF
-- Python LSP
require'lspconfig'.pyright.setup{settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          stubPath = os.getenv('STUBSPATH'),
        }
      }
    }
}

require'lspconfig'.ccls.setup { -- C++ LSP
  init_options = {
    -- Path where the compilationdatabase.json is located
    compilationDatabaseDirectory = os.getenv('CPP_BUILD_DIR');
    index = {
      threads = 0;
    };
    clang = {
      extraArgs= { '-Wno-everything'} ; -- Handled by linters
   };
  }
}

-- Disable underline in diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
 vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    update_in_insert = false,
  }
)

EOF
