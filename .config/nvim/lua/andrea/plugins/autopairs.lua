return {
    "windwp/nvim-autopairs",
    event = { "BufNewFile", "BufReadPost", "FileReadPost" },
    dependencies = {
        "hrsh7th/nvim-cmp",        -- The completion plugin
    },
    opts = {
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<C-s>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            before_key = "e",
            after_key = "w",
            cursor_pos_before = true,
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        }
    },

    config = function(LazyPlugin, opts)
        require("nvim-autopairs").setup(opts)
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        local cmp = require("cmp")
        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done { map_char = { tex = "" } }
        )
    end,
}
