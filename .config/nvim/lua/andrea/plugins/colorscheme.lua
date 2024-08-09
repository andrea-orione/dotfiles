-- Colorschemes
return {
    {
        "folke/tokyonight.nvim",
        lazy = true, -- NOTE: Set to false if you want so use this
        priority = 1000, -- to load before everything
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local colorscheme = "carbonfox"
            vim.cmd("colorscheme " .. colorscheme)
        end

    },
}
