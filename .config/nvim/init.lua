--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ /
--
--
-- Customization of Neovim

require("andrea.options")
require("andrea.keymaps")
require("andrea.autocommands")

require("andrea.plugins")

require("andrea.comment") -- TODO: Fix this

-- Appearence
require("andrea.colorscheme")
require("andrea.nvim-tree")  -- TODO: consider changing to neo-tree
require("andrea.bufferline") -- TODO: Fix this
require("andrea.toggleterm")
require("andrea.indentline")
require("andrea.alpha")
require("andrea.lualine") -- TODO: set this up

-- Integrations
require("andrea.gitsigns")

-- Editing and coding
require("andrea.cmp")
require("andrea.project")
require("andrea.telescope")
require("andrea.lsp")
require("andrea.treesitter")
require("andrea.autopairs")
require("andrea.whichkey")

-- Specific filetypes
require("andrea.neorg")
vim.cmd("source ~/.config/nvim/lua/andrea/latex.vim")
