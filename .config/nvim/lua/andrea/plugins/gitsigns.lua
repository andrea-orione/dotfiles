return {
    "lewis6991/gitsigns.nvim",
    event = { "BufNewFile", "BufReadPost", "FileReadPost" },
    opts = {
        signs = {
            add = { text = " " },
            change = { text = " " },
            delete = { text = " " },
            topdelete = { text = "󱅁 " },
            changedelete = { text = "󰍷 " },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        attach_to_untracked = true,
        max_file_length = 4000, -- Disable if file is longer than this (in lines)

        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")
            local keymap = function(mode, keys, func, description)
                vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, silent = true, desc = description })
            end

            -- TODO: Check shortcuts maybe add fugitive
            keymap("n", "<leader>gj", gitsigns.next_hunk, "Next Hunk")
            keymap("n", "<leader>gk", gitsigns.prev_hunk, "Prev Hunk")
            keymap("n", "<leader>gl", gitsigns.blame_line, "Blame")
            keymap("n", "<leader>gp", gitsigns.preview_hunk, "[P]review Hunk")
            keymap("n", "<leader>gr", gitsigns.reset_hunk, "[R]eset Hunk")
            keymap("n", "<leader>gR", gitsigns.reset_buffer, "[R]eset Buffer")
            keymap("n", "<leader>gs", gitsigns.stage_hunk, "[S]tage Hunk")
            keymap("n", "<leader>gu", gitsigns.undo_stage_hunk, "[U]ndo Stage Hunk")
            keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "[D]iff")
        end
    }

}
