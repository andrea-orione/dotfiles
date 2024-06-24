local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("Something went wrong loading telescope")
    return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {

        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        planets = {
            show_pluto = true,
        },
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
    },
})

pcall(telescope.load_extension, "projects")
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

-- Keymaps
local keymap = function(mode, keys, func, description)
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = description })
end

keymap("n", "<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>", "[F]ind Text")
keymap("n", "<leader>P", require("telescope").extensions.projects.projects, "[P]rojects")
keymap("n", "<leader>b", function()
    require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = true }))
end, "[B]uffers")
keymap("n", "<leader>f", function()
    require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))
end, "[F]ind files")

keymap("n", "<leader>go", "<cmd>Telescope git_status<cr>", "[O]pen changed file")
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", "[C]heckout branch")
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", "[C]heckout commit")

keymap("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", "[D]ocument [D]iagnostics")
keymap("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>", "[W]orkspace Diagnostics")
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "Document [S]ymbols")
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace [S]ymbols")

keymap("n", "<leader>sb", "<cmd>Telescope git_branches<cr>", "Checkout [b]ranch")
keymap("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>", "[C]olorscheme")
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", "Find [H]elp")
keymap("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", "[M]an Pages")
keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", "Open [R]ecent File")
keymap("n", "<leader>sR", "<cmd>Telescope registers<cr>", "[R]egisters")
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", "[K]eymaps")
keymap("n", "<leader>sC", "<cmd>Telescope commands<cr>", "[C]ommands")
