return {
    "nvim-neorg/neorg",
    dependencies = { "nvim-lua/plenary.nvim" },
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
