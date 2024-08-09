-- File explorer
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<leader>pe", "<cmd>NvimTreeToggle<cr>", desc = "[E]xplorer" }
    },
    opts = {
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        renderer = {
            root_folder_modifier = ":t",
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "S",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
        view = {
            width = 30,
            side = "left",
        },
    },
}
