-- Fuzzy finder
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-ui-select.nvim" -- Makes vim core stuff use in telescope
    },
    -- TODO: Ui select doesn't work

    opts = {
        defaults = { -- global configuration
            prompt_prefix = "  ",
            selection_caret = " ",
            path_display = { "smart" },
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",

                    ["<C-c>"] = false,
                },
                n = {
                    ["<C-c>"] = "close",
                    ["q"] = "close",
                }
            },
        },
        pickers = { -- per picker configuration
            find_files = {
                hidden = true,
                no_ignore = true,
                no_ignore_parent = true,
            },
            live_grep = {
                theme = "ivy",
            },
            -- planets = { -- For the day you feel stupid
            --     show_pluto = true,
            --     show_moon = true,
            -- },
        },
        extensions = {
            ["ui-select"] = { require("telescope.themes").get_dropdown() },
        }
    },

    config = function(LazyPlugin, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("projects")
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")

        -- keymap
        local keymap = function(mode, keys, func, description)
            vim.keymap.set(mode, keys, func, { desc = description })
        end
        local builtin = require("telescope.builtin")

        keymap("n", "<leader>F", builtin.live_grep, "[F]ind Text")
        keymap("n", "<leader>P", telescope.extensions.projects.projects, "[P]rojects")
        keymap("n", "<leader>b", builtin.buffers, "[B]uffers")
        keymap("n", "<leader>f", builtin.find_files, "Find [F]iles")

        keymap("n", "<leader>go", builtin.git_status, "[O]pen changed file")
        keymap("n", "<leader>gb", builtin.git_branches, "[C]heckout branch")
        keymap("n", "<leader>gc", builtin.git_commits, "[C]heckout commit")
        keymap("n", "<leader>gf", builtin.git_files, "Show tracked [F]iles")

        keymap("n", "<leader>dl", function() 
            builtin.diagnostics({ bufnr=0 })
        end, "Document Diagnostics [L]ist")
        keymap("n", "<leader>dw", builtin.diagnostics, "Diagnostics for [W]orkspace")

        keymap("n", "<leader>ls", builtin.lsp_document_symbols, "Document [S]ymbols")
        keymap("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, "Workspace [S]ymbols")

        keymap("n", "<leader>tc", builtin.colorscheme, "[C]olorscheme")
        keymap("n", "<leader>th", builtin.help_tags, "Find [H]elp")
        keymap("n", "<leader>tM", builtin.man_pages, "[M]an Pages")
        keymap("n", "<leader>tr", builtin.oldfiles, "Open [R]ecent File")
        keymap("n", "<leader>tR", builtin.registers, "[R]egisters")
        keymap("n", "<leader>tk", builtin.keymaps, "[K]eymaps")
        keymap("n", "<leader>tC", builtin.commands, "[C]ommands")
    end,
}
