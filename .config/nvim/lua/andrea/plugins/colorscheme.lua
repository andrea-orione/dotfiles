-- Colorschemes
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1500,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1500,
        opts = {
            options = {
                styles = {
                    comments = "italic",
                    conditionals = "NONE",
                    constants = "NONE",
                    functions = "italic",
                    keywords = "italic",
                    numbers = "NONE",
                    operators = "NONE",
                    strings = "NONE",
                    types = "bold",
                    variables = "italic",
                },
            },
        },
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1400, -- The last colorscheme to be loaded
        opts = {
            style = 'darker',
            ending_tildes = false,

            toggle_style_key = "<leader>td",
            toggle_style_list = { 'darker', 'deep', 'warmer' },

            code_style = {
                comments = 'italic',
                keywords = 'italic,bold',
                functions = 'italic',
                strings = 'none',
                variables = 'italic'
            },
        },
        config = function(_, opts)
            require("onedark").setup(opts)
            local colorscheme = "carbonfox"
            vim.cmd("colorscheme " .. colorscheme)
        end
    },
}
