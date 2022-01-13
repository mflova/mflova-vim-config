" Set colortheme
syntax on
colorscheme tokyonight " OceanicNext, hybrid or tokyonight, molokai
                        " For nebulous only uncomment its lua block below 

" OceanicNext is being used
"let g:airline_theme='oceanicnext'

" Hybrid is being used

" TokyoNight is being used
lua vim.g.tokyonight_style = "night"

" Nebulous theme is used
lua << EOF
--require("nebulous").setup {
--  variant = "midnight", -- midnight, night and fullmoon
--}
EOF

" STATUSLINE
" Init the status bar with the diagnos ON/OFF
function! UpdateStatusDiagsAndCmp()
    let l:diags_status = ' '
    if g:mflova_diagnostics_status == 1
        let l:diags_status = l:diags_status . ''
    else
        let l:diags_status = l:diags_status . 'X'
    endif

    let l:cmp_status = ' '
    if g:mflova_cmp_status == 1
        let l:cmp_status = l:cmp_status . ''
    else
        let l:cmp_status = l:cmp_status . 'X'
    endif
    return l:diags_status . '  ' . l:cmp_status
endfunction

" Edit the icons of the Spotify status component
function! UpdateSpotifyComponent()
    let l:diags_status = ' '
    if g:mflova_diagnostics_status == 1
        let l:diags_status = l:diags_status . ''
    else
        let l:diags_status = l:diags_status . 'X'
    endif

    let l:cmp_status = ' '
    if g:mflova_cmp_status == 1
        let l:cmp_status = l:cmp_status . ''
    else
        let l:cmp_status = l:cmp_status . 'X'
    endif
    return l:diags_status . '  ' . l:cmp_status
endfunction

lua <<EOF
local status = require'nvim-spotify'.status

local function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

-- Overwrites the default icons
function updateSpotifyStatusComponent()
  local curr_status = status.listen()
  local new_status = curr_status
    if string.find(curr_status, '⏸') then
        new_status = '' .. string.sub(new_status, 4)
    end
    if string.find(curr_status, '▶') then
        new_status = '▶' .. string.sub(new_status, 4)
    end
   return new_status
end

status:start()
-- Guess where I am located inside the file
require("nvim-gps").setup({
   icons = {
      ["class-name"] = 'ﴯ ',      -- Classes and class-like objects
      ["function-name"] = ' ',   -- Functions
      ["method-name"] = ' ',     -- Methods (functions inside class-like objects)
      ["container-name"] = '⛶ ',  -- Containers (example: lua tables)
      ["tag-name"] = '炙'         -- Tags (example: html tags)
    },
}
)
local gps = require("nvim-gps")
-- Statusline
require('lualine').setup {
  options = { theme  = require'lualine.themes.auto' },
  sections = {
     lualine_a = {'mode'},
     lualine_b = {'branch', 'diff'},
     lualine_c = {'filename', {gps.get_location, cond = gps.is_available}},
     lualine_x = {updateSpotifyStatusComponent, 'diagnostics', 'UpdateStatusDiagsAndCmp','filetype'},
     lualine_y = {'progress'},
     lualine_z = {'location'}
  },
}
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


