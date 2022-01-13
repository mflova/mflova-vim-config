" README
" COMPILATION DATABASE: It is necessary to tell the CPP based linters how to
" compile the program. It can be done by adding
" set(CMAKE_EXPORT_COMPILE_COMMANDS) in the CMakeLists or with the flag
" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON in the cmake command. This will generate
"  a compilationcommands.json that needs to be read by setting the env
"  variable CPP_BUILD_DIR.
"
" STUBSPATH: Where the stubs are read. Set it as env variable. It is
" recommended to be the same one as MYPYPATH, so that both Pyright and MYPY
" both read the stubs from the same folder. Stubs are generated by a command
" in vim that uses stubgen (mypy) and whose output is MYPYPATH. Therefore, by
" setting STUBSPATH to MYPYPATH will make both of them to work.


" Toggle Autocomplete
nmap <silent>lt :call ToggleCmp()<CR>:call ToggleDiagWrapper()<CR>

lua << EOF

-- Autocomplete
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) -- To install the cmp in the LSP. nvim-cmp

-- Python LSP
--require'lspconfig'.pyright.setup{
--  capabilities = capabilities; -- Autocomplete. Line from nvim-cmp
--    settings = {
--      python = {
--        analysis = {
--          autoSearchPaths = true,
--          diagnosticMode = "workspace", -- openFilesOnly is the other option
--          stubPath = os.getenv('STUBSPATH'),
--          typeCheckingMode = "off", -- linting disable, as mypy is much more accurate at the moment and the stubs are better read
--        }
--      }
--    }
--}

-- Python LSP
require'lspconfig'.pylsp.setup{
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {enabled = false,},
                pyflakes = {enabled = false,},
                pylsp_mypy = {
                    strict = true,
                    enabled = true,
                    live_mode = true,
                    overrides = {"--warn-unreachable", true},
                    -- TODO activate unreachable https://github.com/Richardk2n/pylsp-mypy
                },
            },
        },
    },
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

-- Rounded borders when hovering
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded"
  }
)


EOF
