-- Keybinding helper
return {
    "folke/which-key.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {
        preset = "classic", -- Options are false, classic, modern, helix
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            -- Help for default keybindings
            presets = {
                operators = true,
                motions = true,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },
        layout = {
            width = { min = 20, max = 50 },
            spacing = 3,
            align = "left",
        },
        keys = {
            scroll_down = "<c-d>",
            scroll_up = "<c-u>",
        },
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        show_help = true,
        show_keys = true,
        -- Groups definition
        spec = {
            { "<leader>d", group = "[D]iagnostics" },
            { "<leader>g", group = "[G]it" },
            { "<leader>l", group = "[L]SP" },
            { "<leader>p", group = "[P]anels" },
            { "<leader>s", group = "[S]earch" },
            { "<leader>t", group = "[T]elescope" },
            { "<leader>x", group = "E[X]ecute" },
        },
    },
}

