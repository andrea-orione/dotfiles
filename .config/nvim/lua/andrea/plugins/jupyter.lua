return {
    {
        "GCBallesteros/jupytext.nvim",
        event = "VeryLazy",
        opts = {
            style = "hydrogen",
            output_extension = "auto",
            force_ft = nil,
            custom_language_formatting = {
                -- python = {
                --     extension = "qmd",
                --     style = "quarto",
                --     force_ft = "quarto", -- you can set whatever filetype you want here
                -- },
            },
        }
    },
    --     {
    --         "benlubas/molten-nvim",
    --         event = "VeryLazy",
    --         dependencies = { "3rd/image.nvim" },
    --         build = ":UpdateRemotePlugins",
    --         init = function()
    --             -- these are examples, not defaults. Please see the readme
    --             vim.g.molten_image_provider = "image.nvim"
    --             vim.g.molten_output_win_max_height = 20
    --         end,
    --     }
}
