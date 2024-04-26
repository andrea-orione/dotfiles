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
    { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }, --  ful lua functions  d by lots of plugins
    { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" }, -- Autopairs, integrates with both cmp and treesitter
    { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" },
    { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" },
    { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" },
    { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" },
    { "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" },
	  { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
    { "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" },
    { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" },
    { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" },
    { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" },
	  {"folke/which-key.nvim"},

  -- Startup screen
    { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" },

  -- Status line tab line and other lines 
    "nvim-lualine/lualine.nvim", -- statuts line


	-- Colorschemes
    "folke/tokyonight.nvim", -- tokyonight
    "EdenEast/nightfox.nvim", -- nightfox
  --  "svermeulen/text-to-colorscheme.nvim", -- to generate a colorscheme from a text prompt

  -- Colors
    "NvChad/nvim-colorizer.lua",

	-- Cmp 
    { "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }, -- The completion plugin
    { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- buffer completions
    { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }, -- path completions
	  { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }, -- snippet completions
	  { "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" },
	  { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },

	-- Snippets
    { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }, --snippet engine
    { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }, -- a bunch of snippets to  

	-- LSP
	--   { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }, -- enable LSP
    "neovim/nvim-lspconfig",
    { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12"}, -- simple to   language server installer
  --   { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" },
    "williamboman/mason-lspconfig.nvim",
	  { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }, -- for formatters and linters
    { "RRethy/vim-illuminate", commit = "d6ca7f77eeaf61b3e6ce9f0e5a978d606df44298" },

	-- Telescope
	  "nvim-telescope/telescope.nvim",
	--  { "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" },

	-- Treesitter
	  {"nvim-treesitter/nvim-treesitter", commit = "226c1475a46a2ef6d840af9caa0117a439465500"},

	-- Git
	  { "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" },

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
    -- "kana/vim-textobj-line",
    -- "GCBallesteros/vim-textobj-hydrogen",
    "GCBallesteros/jupytext.vim",

    -- Images
    "edluffy/hologram.nvim",
})
