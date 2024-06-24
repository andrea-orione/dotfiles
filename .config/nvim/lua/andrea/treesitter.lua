local treesitter = require "nvim-treesitter"
require("nvim-treesitter.install").prefer_git = true
local configs = require "nvim-treesitter.configs"

local options = {
    ensure_installed = { -- put the language you want in this array
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "vimdoc",
    },
    auto_install = true,
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true,       -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css", "ruby" } },
}

treesitter.setup()
configs.setup(options)
