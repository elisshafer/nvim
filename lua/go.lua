require "paq" { {"fatih/vim-go", tag="*"} }
require'lspconfig'.gopls.setup{}

vim.g["go_def_mode"]="gopls"
vim.g["go_info_mode"]="gopls"
