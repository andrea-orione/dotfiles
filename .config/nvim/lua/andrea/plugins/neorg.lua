-- TODO: Consider adding latex and presenter
-- TODO: Add completion
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
                    folds = false,
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
