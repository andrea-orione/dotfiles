local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gitsigns.setup({
    signs = {
        add = { text = " " },
        change = { text = " " },
        delete = { text = " " },
        topdelete = { text = "󱅁 " },
        changedelete = { text = "󰍷 " },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
})

local keymap = function(mode, keys, func, description)
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = description })
end

keymap("n", "<leader>gj", gitsigns.next_hunk, "Next Hunk")
keymap("n", "<leader>gk", gitsigns.prev_hunk, "Prev Hunk")
keymap("n", "<leader>gl", gitsigns.blame_line, "Blame")
keymap("n", "<leader>gp", gitsigns.preview_hunk, "[P]review Hunk")
keymap("n", "<leader>gr", gitsigns.reset_hunk, "[R]eset Hunk")
keymap("n", "<leader>gR", gitsigns.reset_buffer, "[R]eset Buffer")
keymap("n", "<leader>gs", gitsigns.stage_hunk, "[S]tage Hunk")
keymap("n", "<leader>gu", gitsigns.undo_stage_hunk, "[U]ndo Stage Hunk")
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "[D]iff")
