local fn = vim.fn

-- Automatically install packer.
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end


-- Reload neovim whenever plugins.lua is written.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Packer uses a popup window.
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    git = {
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer manages itself

  -- Utilities
  use 'nvim-lua/plenary.nvim'

  -- Language Server Protocol
  use {
    'neovim/nvim-lspconfig',
    config = function() require'lspconfig'.gopls.setup{} end,
  }

  -- Snippets
  use 'norcalli/snippets.nvim'

  -- Text Manipulation
  use 'rstacruz/vim-closer'
  use 'tpope/vim-surround'
  -- use 'windwp/nvim-spectre'
 
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'neovim/nvim-lspconfig'},
      {'sharkdp/fd'},
      {'nvim-tree/nvim-web-devicons'},
      {'nvim-telescope/telescope-fzf-native.nvim'},
    },
  }

  -- Color Schemes
  use {'dracula/vim', as = 'dracula'}
  use {'folke/tokyonight.nvim', as = 'tokyonight'}
  use {'shaunsingh/nyoom.nvim', as = 'nyoom'} -- not working
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function() vim.cmd('colorscheme rose-pine') end
  } 


  use  "mbbill/undotree" 

  use 'mfussenegger/nvim-dap'


--   use 'sharkdp/fd'
--  use 'nvim-tree/nvim-web-devicons'

  -- Go
  use 'fatih/vim-go'
  use { 
    "ray-x/go.nvim",
    opt = false,
    cmd = "BufWritePre *.go :silent! lua require('go.format').gofmt()",
    requires = { {'ray-x/guihua.lua'} },
    config = function() 
      require('go').setup( {
        goimport = 'gopls',
        gofmt = 'gopls', -- if set to gopls will use golsp format
        max_line_len = 90,
        tag_transform = false,
        test_dir = '',
        comment_placeholder = '  ',
        lsp_cfg = true, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
        dap_debug = true,
      }) 
    end,
  }
end)
