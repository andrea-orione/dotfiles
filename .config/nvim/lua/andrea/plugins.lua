-- PLUGINS
-- This file sets up lazy and installs all the needed packages

-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    print("Installing lazy close and reopen Neovim...")
end
vim.opt.rtp:prepend(lazypath)

-- a protected call so we don't error out on first
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    vim.notify("Something went wrong loading lazy")
    return
end

-- Install your plugins here
lazy.setup({
    -- Dependecies and miscellaneous
    "nvim-lua/plenary.nvim", -- functions used by lots of plugins
    {
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects. Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })
            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()
        end,
    },                      -- Collection of small packages
    "numToStr/Comment.nvim", -- Easy commenting
    "JoosepAlviste/nvim-ts-context-commentstring",
    { "kyazdani42/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    "moll/vim-bbye", -- Close buffers without closing a window
    "tpope/vim-sleuth",

    -- Appearence
    "nvim-tree/nvim-tree.lua",            -- Tree file view
    "akinsho/bufferline.nvim",            -- Bufferline
    "akinsho/toggleterm.nvim",            -- Terminal inside vim (better to use tmux)
    "lukas-reineke/indent-blankline.nvim", -- Indentation line
    "goolord/alpha-nvim",                 -- Startup screen
    "nvim-lualine/lualine.nvim",          -- Status line tab line and other lines

    -- Colorschemes
    { "folke/tokyonight.nvim",        priority = 1000 }, -- to load before everything
    { "EdenEast/nightfox.nvim",       priority = 1000 },

    { "NvChad/nvim-colorizer.lua",    opt = {} },                                -- Colors
    { "folke/todo-comments.nvim",     event = "VimEnter",            opts = { signs = false } }, -- Colored todos

    -- Integrations
    "lewis6991/gitsigns.nvim",       -- Git
    "christoomey/vim-tmux-navigator", -- Tmux

    -- Snippets
    "L3MON4D3/LuaSnip",            --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of additional snippets

    -- Cmp
    "hrsh7th/nvim-cmp",        -- The completion plugin
    "hrsh7th/cmp-buffer",      -- buffer completions
    "hrsh7th/cmp-path",        -- path completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    { "windwp/nvim-autopairs",           event = "InsertEnter" }, -- Autopairs, integrates with both cmp and treesitter

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
    },
    "ahmedkhalf/project.nvim", -- Project management

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            { "folke/neodev.nvim", opts = {} },
        },
    },
    "williamboman/mason.nvim", -- language server installer
    "williamboman/mason-lspconfig.nvim",
    "RRethy/vim-illuminate",  -- to highlight references of word

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- keybinding helper
    { "folke/which-key.nvim",            event = "VimEnter" },

    -- Specific filetypes
    { "nvim-neorg/neorg",                version = "v7.0.0" }, -- Neorg
    -- TODO: check if there are newer versions
    "chrisbra/csv.vim",                        -- Csv
    "ixru/nvim-markdown",                      -- Markdown
    "lervag/vimtex",                           -- Latex
})
