local fn = vim.fn

-- Automatically install packer
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("navarasu/onedark.nvim") -- One Dark theme
  use("sainnhe/gruvbox-material") -- gruvbox-material theme
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("windwp/nvim-ts-autotag") -- Autotags and autorename tags with treesitter
  use("kyazdani42/nvim-tree.lua")
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye") -- Smarter closing buffers
  use("folke/which-key.nvim")
  use("fannheyward/telescope-coc.nvim")
  use("nvim-lualine/lualine.nvim")
  use("kyazdani42/nvim-web-devicons") -- nice icons in nvim-tree and other plugins
  use("numToStr/Comment.nvim") -- comment line on gcc
  use("JoosepAlviste/nvim-ts-context-commentstring") -- context commenting, for ex in rxjs files
  use("lewis6991/gitsigns.nvim") -- change signs on the left signs wirh some nice functions like go to next change, preview what was changed etc.
  use({ -- Show css colors
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
        html = { names = true }, -- Disable parsing "names" like Blue or Gray
      })
    end,
  })
  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "info",
        auto_session_suppress_dirs = { "~/", "~/Projects" },
      })
    end,
  })

  -- cmp plugins
  -- TODO remove config files if coc stays - and it will probably
  -- use("hrsh7th/nvim-cmp") -- The completion plugin
  -- use("hrsh7th/cmp-buffer") -- buffer completions
  -- use("hrsh7th/cmp-path") -- path completions
  -- use("hrsh7th/cmp-cmdline") -- cmdline completions
  -- use("saadparwaiz1/cmp_luasnip") -- snippet completions
  -- use("hrsh7th/cmp-nvim-lsp") -- use cmp to communicate with lsp
  -- use("hrsh7th/cmp-nvim-lua")

  -- LSP
  -- use("neovim/nvim-lspconfig") -- enable LSP
  -- use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  -- use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  -- use("jose-elias-alvarez/nvim-lsp-ts-utils") -- better formatting and linting for ts
  use { 'neoclide/coc.nvim', branch = 'release' }

  -- snippets
  -- use("L3MON4D3/LuaSnip") --snippet engine
  -- use("rafamadriz/friendly-snippets") -- a bunch of snippets to use


  -- fuzzy finding
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-media-files.nvim")

  -- treesitter for better syntax highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
