-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
		    "git",
		    "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
		    "--branch=stable", -- latest stable release
		    lazypath,
    })
    print("Installing lazy close and reopen Neovim...")
end
vim.opt.rtp:prepend(lazypath)

--   a protected call so we don't error out on first  
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    vim.notify("Something went wrong loading lazy")
	  return
end

-- Install your plugins here
lazy.setup({
    "nvim-lua/plenary.nvim", -- functions used by lots of plugins
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "kyazdani42/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    "akinsho/bufferline.nvim",
	  "moll/vim-bbye",
    "akinsho/toggleterm.nvim",
    "ahmedkhalf/project.nvim",
    "lewis6991/impatient.nvim",
    {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}},
	  "folke/which-key.nvim",

  -- Startup screen
    "goolord/alpha-nvim",

  -- Status line tab line and other lines 
    "nvim-lualine/lualine.nvim", -- statuts line

	-- Colorschemes
    "folke/tokyonight.nvim", -- tokyonight
    "EdenEast/nightfox.nvim", -- nightfox
  --  "svermeulen/text-to-colorscheme.nvim", -- to generate a colorscheme from a text prompt

  -- Colors
    "NvChad/nvim-colorizer.lua",

  -- Cmp 
    "hrsh7th/nvim-cmp", -- The completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
	  "saadparwaiz1/cmp_luasnip", -- snippet completions
	  "hrsh7th/cmp-nvim-lsp",
	  "hrsh7th/cmp-nvim-lua",

	-- Snippets
    "L3MON4D3/LuaSnip", --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to  

	-- LSP
	--   { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }, -- enable LSP
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim", -- simple to   language server installer
  --   { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" },
    "williamboman/mason-lspconfig.nvim",
	  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    "RRethy/vim-illuminate",

	-- Telescope
	  "nvim-telescope/telescope.nvim", -- commit = "76ea9a898d3307244dce3573392dcf2cc38f340f"

	-- Treesitter
	  "nvim-treesitter/nvim-treesitter",

	-- Git
    "lewis6991/gitsigns.nvim",

  -- Tmux
    "christoomey/vim-tmux-navigator",

  -- Neorg
    -- {"vhyrro/luarocks.nvim", priority = 1000, config = true},
    -- {"nvim-neorg/neorg", dependencies = { "luarocks.nvim" }},
    {"nvim-neorg/neorg", version = "v7.0.0"},

  -- Csv
    "chrisbra/csv.vim",

  -- Markdown
    "ixru/nvim-markdown",

  -- Latex
    'lervag/vimtex',

  -- Jupyter 
    "hkupty/iron.nvim",
    "kana/vim-textobj-user",
    "kana/vim-textobj-line",
    "GCBallesteros/vim-textobj-hydrogen",
    "GCBallesteros/jupytext.vim",
})
