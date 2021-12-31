" Set colortheme
syntax on
colorscheme tokyonight " OceanicNext, hybrid or tokyonight, molokai

" OceanicNext is being used
"let g:airline_theme='oceanicnext'

" Hybrid is being used

" TokyoNight is being used
lua vim.g.tokyonight_style = "night"


lua <<EOF
-- Tresitter used for syntax highlighting enhanced
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {'vim', 'markdown'}
  }
}

-- Icons in gutter
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- Virutal text icons (circles)
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- Could be '●', '▎', 'x'
  }
})
EOF


