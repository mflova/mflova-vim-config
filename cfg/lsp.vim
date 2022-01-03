nmap <silent>lt :call ToggleCmp()<CR>:call ToggleDiagWrapper()<CR>

lua << EOF
require'toggle_lsp_diagnostics'.init()

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) -- To install the cmp in the LSP. nvim-cmp

-- Python LSP
require'lspconfig'.pyright.setup{
  capabilities = capabilities; -- Autocomplete. Line from nvim-cmp
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          stubPath = os.getenv('STUBSPATH'),
        }
      }
    }
}

-- C++ LSP
local cpp_compilation_database_dir = os.getenv('CPP_BUILD_DIR')
require'lspconfig'.ccls.setup{
  capabilities = capabilities; -- Autocomplete. Line from nvim-cmp
  init_options = {
    -- Path where the compilationdatabase.json is located
    compilationDatabaseDirectory = cpp_compilation_database_dir;
    index = {
      threads = 0;
    };
   clang = {
      extraArgs= {'-Wno-everything'} ; -- Handled separately by linters to avoid duplications
   };
  }
}

-- CMAKE
require'lspconfig'.cmake.setup{capabilities = capabilities;}
-- YAML
require'lspconfig'.yamlls.setup{capabilities = capabilities;}
-- VIM
require'lspconfig'.vimls.setup{capabilities = capabilities;}
-- BASH
require'lspconfig'.bashls.setup{capabilities = capabilities;}
-- RST
require'lspconfig'.esbonio.setup {
  init_options = {
    server = {
      logLevel = "debug"
    },
    sphinx = {
      confDir = "docs/",
      srcDir = "${confDir}/../docs-src"
    }
}
}
-- MARDKWON/MD
require'lspconfig'.ltex.setup{
capabilities = capabilities;
    filetypes = { "bib", "markdown", "org", "plaintex", "rnoweb", "tex" };
    settings = {
        ltex = { 
           language = 'en';
        };
    };
}
-- LUA
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
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
