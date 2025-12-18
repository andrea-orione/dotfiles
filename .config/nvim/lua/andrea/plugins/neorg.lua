return {
    "nvim-neorg/neorg",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/lua-utils.nvim",
        "nvim-neotest/nvim-nio",
        "MunifTanjim/nui.nvim",
        "pysan3/pathlib.nvim"
    },
    lazy = false,
    version = "*",
    event = "VeryLazy",
    build = ":Neorg sync-parsers",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = {
                    folds = true,
                }
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/Varie/Notes",
                        todo = "~/Varie/Todo",
                    }
                }
            }
        }
    }
}
