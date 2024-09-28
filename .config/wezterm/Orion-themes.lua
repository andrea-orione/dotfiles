--    ____     ____
--  /  __  \ /  __  \
-- |  |__|  |  |  |  |  Andrea Orione
-- |   __   |  |  |  |  https://www.github.com/andrea-orione
-- |  |  |  |  |__|  |
-- |__|  |__|\ ____ / 
--
--
-- Orion themes for wezterm

local orion_themes = {
    ['Orion Dark'] = {
        foreground = "#e0e0e0",
        background = "#101016",

        cursor_fg = "#101016", -- text
        cursor_bg = "#219fd5", -- block
        cursor_border = "#219fd5", -- bar, underline and block border
        compose_cursor = "#db990a",

        selection_fg = "#e0e0e0",
        selection_bg = "#25252d",

        ansi = {
            "#040404",
            "#D30102",
            "#00b70a",
            "#db990a",
            "#0cb8c9",
            "#6C00D9",
            "#0cc97e",
            "#e0e0e0",
        },
        brights = {
            "#363636",
            "#db3334",
            "#33c53b",
            "#e2ad3b",
            "#3cc6d3",
            "#8933e0",
            "#3cd397",
            "#f0f0f0",
        },
    },

    ['Orion Blue'] = {
        foreground = "#eeeeee",
        background = "#011627",

        cursor_fg = "#011627",
        cursor_bg = "#219fd5",
        cursor_border = "#219fd5",
        compose_cursor = "#a6e22e",

        selection_bg = "#011627",
        selection_fg = "#219fd5",

        ansi = {
            "#000000",
            "#bb0000",
            "#00b70a",
            "#a6e22e",
            "#00e1ff",
            "#6C00D9",
            "#89DDFF",
            "#eeeeee",
        },
        brights = {
            "#999999",
            "#f07178",
            "#A6E22E",
            "#f7ecb5",
            "#7aa6da",
            "#F92672",
            "#89DDFF",
            "#ffffff",
        },
    },
}

return orion_themes
